"use client";

import React, { useState, useEffect, useRef } from "react";
import Link from "next/link";
import {
  Sparkles,
  Send,
  Scale,
  ShieldCheck,
  FileText,
  Copy,
  Check,
  RefreshCw,
  BookOpen,
  HelpCircle,
  ExternalLink,
  ChevronRight,
  Info,
  Layers,
  ArrowRight,
  MessageSquareQuote,
  Lightbulb
} from "lucide-react";
import { apiClient } from "@/lib/api-client";
import { useAuth } from "@/lib/auth-context";

interface BackendQuickPrompt {
  id: string;
  titleEng: string;
  titleUrdu: string;
  promptEng: string;
  promptUrdu: string;
  category: string;
  icon: string;
}

interface PromptItem {
  labelEn: string;
  labelUr: string;
  promptEn: string;
  promptUr: string;
}

interface QuickPromptCategory {
  titleEn: string;
  titleUr: string;
  icon: string;
  prompts: PromptItem[];
}

interface UserDocOption {
  userDocumentId: number;
  title: string;
  templateTitleEn: string;
  status: string;
}

interface ChatMessage {
  id: string;
  sender: "user" | "assistant";
  text: string;
  model?: string;
  timestamp: string;
}

const DEFAULT_CATEGORIES: QuickPromptCategory[] = [
  {
    titleEn: "Stamp Duty & E-Stamping",
    titleUr: "اسٹامپ پیپر اور ڈیوٹی",
    icon: "stamp",
    prompts: [
      {
        labelEn: "Stamp Duty Calculation",
        labelUr: "اسٹامپ ڈیوٹی حساب",
        promptEn: "What stamp paper value and duty are required for a standard rent agreement in Punjab and Sindh under the Stamp Act 1899?",
        promptUr: "پنجاب اور سندھ میں کرایہ نامہ کے لیے کتنے مالیت کا اسٹامپ پیپر درکار ہے؟"
      },
      {
        labelEn: "E-Stamp Verification",
        labelUr: "ای اسٹامپ تصدیق",
        promptEn: "How can I verify the authenticity of a 32-A e-Stamp paper issued by Punjab Bank or Sindh portal?",
        promptUr: "ای اسٹامپ پیپر کی تصدیق کا طریقہ کار کیا ہے؟"
      }
    ]
  },
  {
    titleEn: "Tenancy & Eviction",
    titleUr: "کرایہ داری اور بے دخلی",
    icon: "home",
    prompts: [
      {
        labelEn: "Tenancy Notice Period",
        labelUr: "کرایہ داری نوٹس پیریڈ",
        promptEn: "What is the mandatory legal notice period required to evict a tenant under the Punjab Rented Premises Act 2009?",
        promptUr: "پنجاب رینٹڈ پریمائزز ایکٹ کے تحت کرایہ دار کو نوٹس دینے کی قانونی مدت کیا ہے؟"
      },
      {
        labelEn: "Security Deposit Rules",
        labelUr: "سیکیورٹی ڈپازٹ قوانین",
        promptEn: "What are the rules and standard deductions for security deposits at the end of a residential tenancy?",
        promptUr: "کرایہ داری ختم ہونے پر سیکیورٹی ڈپازٹ کی واپسی کے کیا اصول ہیں؟"
      }
    ]
  },
  {
    titleEn: "Witnesses & Qanun-e-Shahadat",
    titleUr: "گواہان اور شہادت",
    icon: "users",
    prompts: [
      {
        labelEn: "Witness Competence & Number",
        labelUr: "گواہوں کی تعداد اور شرائط",
        promptEn: "What are the required number and legal competence of witnesses for financial agreements under Article 79 of Qanun-e-Shahadat Order 1984?",
        promptUr: "قانون شہادت 1984 کے تحت مالیاتی معاہدے کے لیے کتنے اور کن گواہوں کی ضرورت ہوتی ہے؟"
      },
      {
        labelEn: "Affidavit Oath Attestation",
        labelUr: "بیان حلفی تصدیق",
        promptEn: "What are the requirements for an affidavit to be legally admissible under the Oaths Act 1873 in Pakistani courts?",
        promptUr: "اووتھس ایکٹ 1873 کے تحت بیان حلفی کی اووتھ کمشنر سے تصدیق کیوں ضروری ہے؟"
      }
    ]
  },
  {
    titleEn: "Employment & NDAs",
    titleUr: "ملازمت اور رازداری",
    icon: "briefcase",
    prompts: [
      {
        labelEn: "Non-Compete Enforceability",
        labelUr: "نان کمپیٹ شق کی قانونی حیثیت",
        promptEn: "Is a post-employment non-compete clause legally enforceable under Section 27 of the Contract Act 1872 in Pakistan?",
        promptUr: "کیا پاکستان میں کنٹریکٹ ایکٹ کے سیکشن 27 کے تحت نان کمپیٹ شق قابل عمل ہے؟"
      },
      {
        labelEn: "Probation & Termination",
        labelUr: "پروبیشن اور برطرفی",
        promptEn: "What are the legal notice requirements for termination of employment during and after probation in Pakistan?",
        promptUr: "پروبیشن پیریڈ کے دوران یا بعد میں ملازم کو نوٹس دینے کے کیا قانونی ضوابط ہیں؟"
      }
    ]
  }
];

export default function AiAssistantPage() {
  const { isAuthenticated } = useAuth();
  const [language, setLanguage] = useState<"en" | "ur">("en");
  const [inputPrompt, setInputPrompt] = useState("");
  const [isAsking, setIsAsking] = useState(false);
  const [copiedId, setCopiedId] = useState<string | null>(null);

  const [userDocuments, setUserDocuments] = useState<UserDocOption[]>([]);
  const [selectedDocId, setSelectedDocId] = useState<number | undefined>(undefined);
  const [categories, setCategories] = useState<QuickPromptCategory[]>(DEFAULT_CATEGORIES);
  
  const [messages, setMessages] = useState<ChatMessage[]>([
    {
      id: "init",
      sender: "assistant",
      text:
        "Welcome to the Legal Saathi AI Assistant! I am an intelligent legal assistant specialized in Pakistani law (Contract Act 1872, Tenancy Acts, Stamp Act 1899, Qanun-e-Shahadat 1984, and ETO 2002).\n\nHow may I help you today? You can choose a quick topic below or type your custom query in English or Urdu.",
      timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      model: "LegalSaathi-Free-Llama3"
    }
  ]);

  const messagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages, isAsking]);

  useEffect(() => {
    // Fetch quick prompts from backend and transform safely
    const loadPrompts = async () => {
      try {
        const res = await apiClient.get<BackendQuickPrompt[]>("/api/ai/quick-prompts");
        if (res.success && Array.isArray(res.data) && res.data.length > 0) {
          // Group flat prompt list by category safely
          const groupMap: { [key: string]: PromptItem[] } = {};
          res.data.forEach((p) => {
            const catKey = p.category || "General";
            if (!groupMap[catKey]) {
              groupMap[catKey] = [];
            }
            groupMap[catKey].push({
              labelEn: p.titleEng || "Legal Query",
              labelUr: p.titleUrdu || "قانونی سوال",
              promptEn: p.promptEng || "",
              promptUr: p.promptUrdu || ""
            });
          });

          const transformed: QuickPromptCategory[] = Object.keys(groupMap).map((catName) => {
            const urduCatName = catName === "Tenancy" ? "کرایہ داری اور بے دخلی"
              : catName === "Affidavit" ? "بیان حلفی اور تصدیق"
              : catName === "DigitalSignature" ? "ڈیجیٹل دستخط اور ای کامرس"
              : catName === "Contracts" ? "معاہدات اور شرائط"
              : catName === "Evidence" ? "گواہان اور قانون شہادت"
              : catName;

            return {
              titleEn: catName,
              titleUr: urduCatName,
              icon: "scale",
              prompts: groupMap[catName] || []
            };
          });

          if (transformed.length > 0) {
            setCategories(transformed);
          }
        }
      } catch (e) {
        // Keep default categories
      }
    };

    const loadUserDocs = async () => {
      if (isAuthenticated) {
        try {
          const res = await apiClient.get<UserDocOption[]>("/api/documents");
          if (res.success && Array.isArray(res.data)) {
            setUserDocuments(res.data);
          }
        } catch (e) {
          // ignore
        }
      }
    };

    loadPrompts();
    loadUserDocs();
  }, [isAuthenticated]);

  const handleSend = async (customPrompt?: string) => {
    const prompt = (customPrompt || inputPrompt).trim();
    if (!prompt) return;

    const userMessage: ChatMessage = {
      id: Date.now().toString(),
      sender: "user",
      text: prompt,
      timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    };

    setMessages((prev) => [...prev, userMessage]);
    setInputPrompt("");
    setIsAsking(true);

    try {
      const res = await apiClient.post<{ answer: string; totalTokens: number; model: string }>(
        "/api/ai/ask",
        {
          prompt,
          languageCode: language,
          documentId: selectedDocId
        }
      );

      if (res.success && res.data) {
        setMessages((prev) => [
          ...prev,
          {
            id: (Date.now() + 1).toString(),
            sender: "assistant",
            text: res.data!.answer,
            model: res.data!.model || "LegalSaathi-Free-Llama3",
            timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          }
        ]);
      } else {
        setMessages((prev) => [
          ...prev,
          {
            id: (Date.now() + 1).toString(),
            sender: "assistant",
            text:
              language === "ur"
                ? "معذرت، اس وقت جواب پروسیس کرنے میں رکاوٹ آئی ہے۔ براہ کرم دوبارہ کوشش کریں۔"
                : "Apologies, we encountered an issue processing your query. Please try again.",
            timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          }
        ]);
      }
    } catch (err: any) {
      setMessages((prev) => [
        ...prev,
        {
          id: (Date.now() + 1).toString(),
          sender: "assistant",
          text: "AI Service Error: " + (err.message || "Failed to reach AI reasoning engine."),
          timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        }
      ]);
    } finally {
      setIsAsking(false);
    }
  };

  const handleCopy = (id: string, text: string) => {
    navigator.clipboard.writeText(text);
    setCopiedId(id);
    setTimeout(() => setCopiedId(null), 2000);
  };

  const handleResetChat = () => {
    setMessages([
      {
        id: "reset",
        sender: "assistant",
        text:
          language === "ur"
            ? "بات چیت کا نیا سیشن شروع ہو چکا ہے۔ آپ مجھ سے پاکستانی قوانین، اسٹامپ ڈیوٹی، یا معاہدوں کے بارے میں کوئی بھی سوال پوچھ سکتے ہیں۔"
            : "Conversation reset. Feel free to ask any question regarding Pakistani law, stamp duties, tenancy, or contract clauses.",
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        model: "LegalSaathi-Free-Llama3"
      }
    ]);
  };

  return (
    <div className="min-h-screen bg-slate-50 py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header Banner */}
        <div className="bg-gradient-to-r from-emerald-900 via-slate-900 to-teal-950 rounded-2xl p-6 text-white shadow-xl flex flex-col md:flex-row items-start md:items-center justify-between gap-4 border border-emerald-800/30">
          <div className="space-y-1.5">
            <div className="flex items-center gap-2.5">
              <div className="w-10 h-10 rounded-xl bg-emerald-500/20 border border-emerald-400/30 flex items-center justify-center text-emerald-300">
                <Sparkles className="w-5 h-5 animate-pulse" />
              </div>
              <div>
                <h1 className="text-xl font-bold tracking-tight flex items-center gap-2">
                  Legal Saathi AI Legal Assistant
                  <span className="text-xs bg-emerald-500/20 border border-emerald-400/30 text-emerald-300 font-semibold px-2 py-0.5 rounded-full">
                    100% Free LLM Engine
                  </span>
                </h1>
                <p className="text-xs text-slate-300">
                  {language === "ur"
                    ? "پاکستانی قوانین کے مطابق مفت اور فوری قانونی رہنمائی حاصل کریں۔"
                    : "Instant legal intelligence compliant with Pakistani statutory frameworks and court precedents."}
                </p>
              </div>
            </div>
          </div>

          <div className="flex items-center gap-3 w-full md:w-auto justify-between md:justify-end">
            {/* Language Switch */}
            <div className="flex items-center bg-slate-800/80 p-1 rounded-xl border border-slate-700 text-xs font-semibold">
              <button
                onClick={() => setLanguage("en")}
                className={"px-3 py-1.5 rounded-lg transition-all " + (language === "en" ? "bg-emerald-600 text-white shadow-sm" : "text-slate-400 hover:text-white")}
              >
                English
              </button>
              <button
                onClick={() => setLanguage("ur")}
                className={"px-3 py-1.5 rounded-lg transition-all " + (language === "ur" ? "bg-emerald-600 text-white shadow-sm font-urdu" : "text-slate-400 hover:text-white")}
              >
                اردو (Nastaliq)
              </button>
            </div>

            <button
              onClick={handleResetChat}
              className="p-2 text-slate-300 hover:text-white bg-slate-800/60 hover:bg-slate-700/80 rounded-xl border border-slate-700 transition-colors flex items-center gap-1.5 text-xs"
              title="Reset Conversation"
            >
              <RefreshCw className="w-3.5 h-3.5" />
              <span className="hidden sm:inline">New Chat</span>
            </button>
          </div>
        </div>

        {/* Main Grid: Left Quick Prompts & Context / Right Chat Window */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
          {/* Left Sidebar: Context & Statutes */}
          <div className="lg:col-span-4 space-y-5">
            {/* Document Context Box */}
            <div className="bg-white rounded-2xl p-4 border border-slate-200 shadow-sm space-y-3">
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold text-slate-900 flex items-center gap-1.5">
                  <FileText className="w-4 h-4 text-emerald-600" />
                  Document Context (Optional)
                </span>
                {selectedDocId && (
                  <button
                    onClick={() => setSelectedDocId(undefined)}
                    className="text-[11px] text-rose-600 hover:underline"
                  >
                    Clear Context
                  </button>
                )}
              </div>
              <p className="text-[11px] text-slate-500">
                Select one of your drafted documents to get tailored advice on its clauses.
              </p>
              {userDocuments && userDocuments.length > 0 ? (
                <select
                  value={selectedDocId || ""}
                  onChange={(e) => setSelectedDocId(e.target.value ? Number(e.target.value) : undefined)}
                  className="w-full text-xs bg-slate-50 border border-slate-200 rounded-xl p-2.5 text-slate-800 focus:outline-none focus:ring-2 focus:ring-emerald-500"
                >
                  <option value="">-- No Document Context Selected --</option>
                  {userDocuments.map((doc) => (
                    <option key={doc.userDocumentId} value={doc.userDocumentId}>
                      {doc.title || doc.templateTitleEn} (#{doc.userDocumentId})
                    </option>
                  ))}
                </select>
              ) : (
                <div className="text-[11px] bg-slate-50 p-2.5 rounded-xl border border-slate-100 text-slate-500 flex items-center justify-between">
                  <span>No saved documents yet</span>
                  <Link href="/templates" className="text-emerald-700 font-semibold hover:underline">
                    Create One
                  </Link>
                </div>
              )}
            </div>

            {/* Quick Prompt Cards */}
            <div className="bg-white rounded-2xl p-4 border border-slate-200 shadow-sm space-y-3">
              <div className="flex items-center gap-1.5 text-xs font-bold text-slate-900">
                <Lightbulb className="w-4 h-4 text-amber-500" />
                <span>Quick Legal Topics</span>
              </div>
              <p className="text-[11px] text-slate-500">
                Click any common Pakistani legal scenario to ask the AI assistant immediately:
              </p>

              <div className="space-y-3">
                {Array.isArray(categories) && categories.map((cat, idx) => (
                  <div key={idx} className="space-y-1.5">
                    <span className="text-[11px] font-semibold text-slate-700 block">
                      {language === "ur" ? cat.titleUr : cat.titleEn}
                    </span>
                    <div className="space-y-1.5">
                      {Array.isArray(cat?.prompts) && cat.prompts.map((p, pIdx) => (
                        <button
                          key={pIdx}
                          onClick={() => handleSend(language === "ur" ? p.promptUr : p.promptEn)}
                          className="w-full text-left p-2 rounded-xl bg-slate-50 hover:bg-emerald-50/80 border border-slate-100 hover:border-emerald-200 transition-all flex items-center justify-between group"
                        >
                          <span className={"text-xs text-slate-700 group-hover:text-emerald-800 line-clamp-1 " + (language === "ur" ? "font-urdu text-right w-full" : "")}>
                            {language === "ur" ? p.labelUr : p.labelEn}
                          </span>
                          <ChevronRight className="w-3.5 h-3.5 text-slate-400 group-hover:text-emerald-600 shrink-0 ml-1" />
                        </button>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Lawyer Review Promo Banner */}
            <div className="bg-gradient-to-br from-emerald-800 to-teal-900 rounded-2xl p-4 text-white space-y-2.5 shadow-md">
              <div className="flex items-center gap-2">
                <ShieldCheck className="w-5 h-5 text-emerald-300" />
                <span className="text-xs font-bold">Need a Certified Opinion?</span>
              </div>
              <p className="text-[11px] text-slate-200 leading-relaxed">
                While Legal Saathi AI provides fast statutory guidance, our verified High Court advocates are available to review your documents with ₹0 review fees.
              </p>
              <Link
                href="/lawyer"
                className="inline-flex items-center gap-1.5 text-xs font-bold bg-white text-emerald-900 px-3.5 py-1.5 rounded-xl hover:bg-emerald-50 transition-colors shadow-sm"
              >
                <span>Find an Advocate</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            </div>
          </div>

          {/* Right Area: Interactive Chat Stream */}
          <div className="lg:col-span-8 flex flex-col bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden h-[650px]">
            {/* Chat Messages */}
            <div className="flex-1 overflow-y-auto p-4 sm:p-6 space-y-4 bg-slate-50/40">
              {Array.isArray(messages) && messages.map((m) => (
                <div
                  key={m.id}
                  className={"flex gap-3 " + (m.sender === "user" ? "justify-end" : "justify-start")}
                >
                  {m.sender === "assistant" && (
                    <div className="w-8 h-8 rounded-xl bg-gradient-to-br from-emerald-600 to-teal-800 flex items-center justify-center text-white shrink-0 mt-1 shadow-sm">
                      <Scale className="w-4 h-4" />
                    </div>
                  )}

                  <div
                    className={
                      "max-w-[85%] rounded-2xl p-4 shadow-sm text-xs leading-relaxed relative group " +
                      (m.sender === "user"
                        ? "bg-emerald-700 text-white rounded-tr-none"
                        : "bg-white text-slate-800 border border-slate-200 rounded-tl-none")
                    }
                  >
                    <div
                      className={
                        "whitespace-pre-wrap " +
                        (m.sender === "assistant" && language === "ur" ? "font-urdu text-sm leading-loose" : "")
                      }
                    >
                      {m.text}
                    </div>

                    <div className="mt-2.5 pt-2 border-t border-slate-100 flex items-center justify-between text-[10px] text-slate-400">
                      <span className="font-mono">{m.timestamp}</span>
                      {m.sender === "assistant" && (
                        <div className="flex items-center gap-3">
                          {m.model && <span className="font-mono text-emerald-600">{m.model}</span>}
                          <button
                            onClick={() => handleCopy(m.id, m.text)}
                            className="text-slate-400 hover:text-emerald-700 transition-colors flex items-center gap-1"
                            title="Copy response"
                          >
                            {copiedId === m.id ? (
                              <>
                                <Check className="w-3 h-3 text-emerald-600" />
                                <span className="text-emerald-600">Copied</span>
                              </>
                            ) : (
                              <>
                                <Copy className="w-3 h-3" />
                                <span>Copy</span>
                              </>
                            )}
                          </button>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              ))}

              {isAsking && (
                <div className="flex gap-3 justify-start">
                  <div className="w-8 h-8 rounded-xl bg-gradient-to-br from-emerald-600 to-teal-800 flex items-center justify-center text-white shrink-0 mt-1 shadow-sm">
                    <Scale className="w-4 h-4" />
                  </div>
                  <div className="bg-white border border-slate-200 p-4 rounded-2xl rounded-tl-none shadow-sm flex items-center gap-2.5 text-xs text-slate-600">
                    <div className="w-4 h-4 border-2 border-emerald-600 border-t-transparent rounded-full animate-spin" />
                    <span>Analyzing statutory provisions & Pakistani case law...</span>
                  </div>
                </div>
              )}

              <div ref={messagesEndRef} />
            </div>

            {/* Chat Input Bar */}
            <div className="p-4 bg-white border-t border-slate-200">
              <form
                onSubmit={(e) => {
                  e.preventDefault();
                  handleSend();
                }}
                className="flex items-center gap-2"
              >
                <input
                  type="text"
                  value={inputPrompt}
                  onChange={(e) => setInputPrompt(e.target.value)}
                  placeholder={
                    language === "ur"
                      ? "پاکستانی قانون، اسٹامپ پیپر، یا معاہدے کے بارے میں سوال درج کریں..."
                      : "Ask any question regarding Pakistani legal requirements, clauses, or stamp duties..."
                  }
                  className={
                    "flex-1 text-xs px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none transition-all " +
                    (language === "ur" ? "text-right font-urdu" : "")
                  }
                />
                <button
                  type="submit"
                  disabled={isAsking || !inputPrompt.trim()}
                  className="px-5 py-3 bg-emerald-700 hover:bg-emerald-800 disabled:opacity-40 text-white rounded-xl shadow-sm transition-all font-semibold text-xs flex items-center gap-1.5"
                >
                  <span>Send</span>
                  <Send className="w-3.5 h-3.5" />
                </button>
              </form>

              <div className="mt-2 flex items-center justify-between text-[10px] text-slate-400">
                <span className="flex items-center gap-1">
                  <Info className="w-3 h-3 text-slate-400" />
                  Statutory references derived from official Pakistani legal codes.
                </span>
                <span>Zero-Cost AI Inference</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
