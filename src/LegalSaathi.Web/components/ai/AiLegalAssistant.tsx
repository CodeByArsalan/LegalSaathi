"use client";

import React, { useState } from "react";
import {
  Sparkles,
  MessageSquare,
  X,
  Send,
  Scale,
  ShieldCheck,
  AlertCircle,
  HelpCircle,
  ChevronRight,
  BookOpen
} from "lucide-react";
import { apiClient } from "@/lib/api-client";

interface AiLegalAssistantProps {
  templateId?: number;
  documentId?: number;
  templateTitle?: string;
  contextJson?: string;
}

interface ChatMessage {
  id: string;
  sender: "user" | "assistant";
  text: string;
  model?: string;
}

export function AiLegalAssistant({
  templateId,
  documentId,
  templateTitle,
  contextJson
}: AiLegalAssistantProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [language, setLanguage] = useState<"ur" | "en">("ur");
  const [inputPrompt, setInputPrompt] = useState("");
  const [messages, setMessages] = useState<ChatMessage[]>([
    {
      id: "welcome",
      sender: "assistant",
      text: language === "ur"
        ? "خوش آمدید! میں لیگل ساتھی AI قانونی معاون ہوں۔ آپ اس دستاویز کے متعلق اسٹامپ پیپر، گواہان، یا قانونی شقوں کے بارے میں کوئی بھی سوال پوچھ سکتے ہیں۔"
        : "Welcome! I am Legal Saathi AI Assistant. Ask me anything regarding Pakistani law, stamp duty, witness rules, or clauses for this document."
    }
  ]);
  const [isAsking, setIsAsking] = useState(false);

  const quickPrompts = language === "ur" ? [
    { label: "📜 اسٹامپ پیپر کی شرط", prompt: "اس دستاویز کے لیے کتنا اسٹامپ پیپر اور اسٹامپ ڈیوٹی درکار ہے؟" },
    { label: "👥 گواہان کی شرائط", prompt: "قانون شہادت کے تحت گواہان کی کیا شرائط ہیں؟" },
    { label: "🏠 کرایہ نامہ کی شرائط", prompt: "کرایہ نامہ میں کرائے میں اضافہ اور نوٹس پیریڈ کا کیا قانون ہے؟" },
    { label: "🚗 گاڑی کا بیع نامہ", prompt: "گاڑی کی فروخت پر بائیو میٹرک تصدیق کیوں ضروری ہے؟" }
  ] : [
    { label: "📜 Stamp Paper & Duty", prompt: "What stamp paper and duty is required for this document in Pakistan?" },
    { label: "👥 Witness Rules", prompt: "What are the witness requirements under Qanun-e-Shahadat 1984?" },
    { label: "🏠 Tenancy & Eviction", prompt: "What are the standard tenancy notice periods under Pakistani law?" },
    { label: "🔒 NDA & Remedies", prompt: "What are the legal remedies for breach of confidentiality in Pakistan?" }
  ];

  const handleSend = async (promptToSend?: string) => {
    const prompt = (promptToSend || inputPrompt).trim();
    if (!prompt) return;

    const userMsg: ChatMessage = {
      id: Date.now().toString(),
      sender: "user",
      text: prompt
    };

    setMessages((prev) => [...prev, userMsg]);
    setInputPrompt("");
    setIsAsking(true);

    try {
      const res = await apiClient.post<{ answer: string; totalTokens: number; model: string }>(
        "/api/ai/ask",
        {
          prompt,
          languageCode: language,
          templateId,
          documentId,
          contextJson
        }
      );

      if (res.success && res.data) {
        const aiData = res.data;
        setMessages((prev) => [
          ...prev,
          {
            id: (Date.now() + 1).toString(),
            sender: "assistant",
            text: aiData.answer,
            model: aiData.model
          }
        ]);
      } else {
        setMessages((prev) => [
          ...prev,
          {
            id: (Date.now() + 1).toString(),
            sender: "assistant",
            text: "معذرت، اس وقت جواب حاصل کرنے میں دشواری ہے۔ براہ کرم دوبارہ کوشش کریں۔"
          }
        ]);
      }
    } catch (err: any) {
      setMessages((prev) => [
        ...prev,
        {
          id: (Date.now() + 1).toString(),
          sender: "assistant",
          text: "Legal Saathi AI Error: " + (err.message || "Failed to reach AI service.")
        }
      ]);
    } finally {
      setIsAsking(false);
    }
  };

  return (
    <>
      {/* Floating Launcher Button */}
      <button
        onClick={() => setIsOpen(true)}
        className="fixed bottom-6 right-6 z-40 flex items-center gap-2 bg-gradient-to-r from-emerald-800 to-teal-900 text-white px-4 py-3 rounded-full shadow-xl hover:shadow-2xl hover:scale-105 transition-all border border-emerald-600/40 group"
      >
        <div className="w-7 h-7 rounded-full bg-emerald-500/20 flex items-center justify-center text-emerald-300">
          <Sparkles className="w-4 h-4 animate-pulse" />
        </div>
        <span className="text-xs font-bold tracking-wide">Legal Saathi AI</span>
      </button>

      {/* Slide-over Drawer */}
      {isOpen && (
        <div className="fixed inset-0 z-50 flex justify-end bg-slate-900/40 backdrop-blur-sm animate-in fade-in duration-200">
          <div className="w-full max-w-md bg-white h-full shadow-2xl flex flex-col border-l border-slate-200 animate-in slide-in-from-right duration-300">
            {/* Header */}
            <div className="p-4 bg-gradient-to-r from-emerald-900 via-slate-900 to-teal-950 text-white flex items-center justify-between border-b border-emerald-800/40">
              <div className="flex items-center gap-2.5">
                <div className="w-8 h-8 rounded-xl bg-emerald-500/20 border border-emerald-400/30 flex items-center justify-center text-emerald-300">
                  <Scale className="w-4 h-4" />
                </div>
                <div>
                  <h3 className="text-sm font-bold flex items-center gap-1.5">
                    Legal Saathi AI <span className="text-[10px] bg-emerald-500/20 text-emerald-300 px-1.5 py-0.5 rounded-full font-medium">Free</span>
                  </h3>
                  <p className="text-[10px] text-slate-300 truncate max-w-[200px]">
                    {templateTitle || "Pakistani Statutory Assistant"}
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2">
                {/* Language Switch */}
                <div className="flex bg-slate-800/60 p-0.5 rounded-lg border border-slate-700 text-[10px] font-semibold">
                  <button
                    onClick={() => setLanguage("ur")}
                    className={"px-2 py-0.5 rounded " + (language === "ur" ? "bg-emerald-600 text-white" : "text-slate-400")}
                  >
                    اردو
                  </button>
                  <button
                    onClick={() => setLanguage("en")}
                    className={"px-2 py-0.5 rounded " + (language === "en" ? "bg-emerald-600 text-white" : "text-slate-400")}
                  >
                    EN
                  </button>
                </div>

                <button
                  onClick={() => setIsOpen(false)}
                  className="p-1.5 text-slate-400 hover:text-white rounded-lg hover:bg-white/10 transition-colors"
                >
                  <X className="w-4 h-4" />
                </button>
              </div>
            </div>

            {/* Messages Area */}
            <div className="flex-1 overflow-y-auto p-4 space-y-3.5 bg-slate-50/50">
              {messages.map((m) => (
                <div
                  key={m.id}
                  className={"flex " + (m.sender === "user" ? "justify-end" : "justify-start")}
                >
                  <div
                    className={
                      "max-w-[85%] p-3.5 rounded-2xl text-xs leading-relaxed " +
                      (m.sender === "user"
                        ? "bg-emerald-700 text-white rounded-br-none shadow-sm"
                        : "bg-white text-slate-800 border border-slate-200 rounded-bl-none shadow-sm " + (language === "ur" ? "font-urdu text-sm" : ""))
                    }
                  >
                    <div className="whitespace-pre-wrap">{m.text}</div>
                    {m.model && (
                      <div className="mt-2 pt-1.5 border-t border-slate-100 flex items-center justify-between text-[9px] text-slate-400 font-mono">
                        <span>Legal Saathi Engine</span>
                        <span>{m.model}</span>
                      </div>
                    )}
                  </div>
                </div>
              ))}

              {isAsking && (
                <div className="flex justify-start">
                  <div className="bg-white border border-slate-200 p-3 rounded-2xl rounded-bl-none shadow-sm flex items-center gap-2 text-xs text-slate-500">
                    <div className="w-3.5 h-3.5 border-2 border-emerald-600 border-t-transparent rounded-full animate-spin" />
                    <span>Consulting Pakistani Legal Statutes...</span>
                  </div>
                </div>
              )}
            </div>

            {/* Quick Prompts */}
            <div className="p-3 bg-white border-t border-slate-100 flex gap-1.5 overflow-x-auto no-scrollbar">
              {quickPrompts.map((qp, idx) => (
                <button
                  key={idx}
                  onClick={() => handleSend(qp.prompt)}
                  className="shrink-0 text-[11px] font-medium bg-slate-100 hover:bg-emerald-50 hover:text-emerald-800 text-slate-700 px-2.5 py-1 rounded-full border border-slate-200 transition-colors"
                >
                  {qp.label}
                </button>
              ))}
            </div>

            {/* Input Bar */}
            <div className="p-3 bg-white border-t border-slate-200">
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
                  placeholder={language === "ur" ? "پاکستانی قانون کے بارے میں سوال پوچھیں..." : "Ask a legal question regarding this document..."}
                  className={"flex-1 text-xs px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none " + (language === "ur" ? "text-right font-urdu" : "")}
                />
                <button
                  type="submit"
                  disabled={isAsking || !inputPrompt.trim()}
                  className="p-2.5 bg-emerald-700 hover:bg-emerald-800 disabled:opacity-40 text-white rounded-xl shadow-sm transition-all"
                >
                  <Send className="w-4 h-4" />
                </button>
              </form>
              <p className="text-[9px] text-slate-400 text-center mt-2">
                Legal Saathi AI provides informational assistance under Pakistani law. Verified lawyer review recommended.
              </p>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
