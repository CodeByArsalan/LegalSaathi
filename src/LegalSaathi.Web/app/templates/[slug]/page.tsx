"use client";

import React, { useState, useEffect, useMemo } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import {
  Scale,
  ShieldCheck,
  Sparkles,
  ArrowRight,
  ArrowLeft,
  CheckCircle2,
  FileText,
  AlertTriangle,
  Lock,
  Download,
  Eye,
  Info
} from "lucide-react";
import { TemplateDetail, FormField } from "@/features/templates/types";
import { apiClient } from "@/lib/api-client";
import { useAuth } from "@/lib/auth-context";
import { AuthModal } from "@/components/auth/AuthModal";
import { AiLegalAssistant } from "@/components/ai/AiLegalAssistant";

export default function TemplateQuestionnairePage() {
  const params = useParams();
  const router = useRouter();
  const slug = params.slug as string;
  const { isAuthenticated, user } = useAuth();

  const [template, setTemplate] = useState<TemplateDetail | null>(null);
  const [formAnswers, setFormAnswers] = useState<Record<string, string>>({});
  const [currentStep, setCurrentStep] = useState(1);
  const [previewTab, setPreviewTab] = useState<"en" | "ur">("ur");
  const [isLoading, setIsLoading] = useState(true);
  const [showAuthModal, setShowAuthModal] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");

  // Load Template and FormFields
  useEffect(() => {
    async function fetchTemplate() {
      setIsLoading(true);
      try {
        const res = await apiClient.get<TemplateDetail>("/api/templates/" + slug);
        if (res.success && res.data) {
          setTemplate(res.data);
          if (user) {
            setFormAnswers((prev) => ({
              ...prev,
              DeponentName: prev.DeponentName || user.fullName,
              SellerName: prev.SellerName || user.fullName,
              LandlordName: prev.LandlordName || user.fullName,
              DisclosingParty: prev.DisclosingParty || user.fullName,
              Cnic: prev.Cnic || user.cnic || "",
            }));
          }
        }
      } catch (err) {
        console.error("Failed to load template", err);
      } finally {
        setIsLoading(false);
      }
    }

    fetchTemplate();
  }, [slug, user]);

  // Group fields by step number
  const stepGroups = useMemo(() => {
    if (!template || !template.formFields) return {};
    const groups: Record<number, FormField[]> = {};
    template.formFields.forEach((field) => {
      const step = field.stepNumber || 1;
      if (!groups[step]) groups[step] = [];
      groups[step].push(field);
    });
    return groups;
  }, [template]);

  const totalSteps = Object.keys(stepGroups).length || 1;
  const currentFields = stepGroups[currentStep] || [];

  const handleInputChange = (key: string, value: string) => {
    setFormAnswers((prev) => ({
      ...prev,
      [key]: value
    }));
  };

  const formatCnic = (val: string) => {
    const digits = val.replace(/\D/g, "").slice(0, 13);
    if (digits.length <= 5) return digits;
    if (digits.length <= 12) return digits.slice(0, 5) + "-" + digits.slice(5);
    return digits.slice(0, 5) + "-" + digits.slice(5, 12) + "-" + digits.slice(12, 13);
  };

  // Interpolate preview text
  const renderedPreview = useMemo(() => {
    if (!template) return "";
    let content = previewTab === "ur" ? template.contentTemplateUr : template.contentTemplateEn;

    Object.entries(formAnswers).forEach(([key, val]) => {
      const token = "{{" + key + "}}";
      const replacement = val.trim() !== "" ? val : "[" + key + "]";
      content = content.replaceAll(token, replacement);
    });

    return content;
  }, [template, formAnswers, previewTab]);

  const validateStep = () => {
    setErrorMsg("");
    for (const field of currentFields) {
      if (field.isRequired) {
        const val = formAnswers[field.fieldKey];
        if (!val || val.trim() === "") {
          setErrorMsg("Please fill in: " + field.labelEn + " (" + field.labelUr + ")");
          return false;
        }
      }
      if (field.fieldType === "Cnic" && formAnswers[field.fieldKey]) {
        const cnic = formAnswers[field.fieldKey];
        if (cnic.length !== 15) {
          setErrorMsg("Please enter a valid 13-digit CNIC (e.g. 35201-1234567-1)");
          return false;
        }
      }
    }
    return true;
  };

  const handleNext = () => {
    if (!validateStep()) return;
    if (currentStep < totalSteps) {
      setCurrentStep((prev) => prev + 1);
    } else {
      handleFinalize();
    }
  };

  const handleFinalize = () => {
    if (!isAuthenticated) {
      setShowAuthModal(true);
      return;
    }

    sessionStorage.setItem(
      "legalsaathi_draft",
      JSON.stringify({
        templateId: template?.templateId,
        templateSlug: template?.slug,
        title: template?.titleEn,
        formAnswers
      })
    );

    router.push("/documents/new");
  };

  if (isLoading) {
    return (
      <div className="min-h-[70vh] flex items-center justify-center">
        <div className="text-center space-y-3">
          <div className="w-8 h-8 border-4 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto" />
          <p className="text-xs text-slate-500 font-medium">Loading questionnaire engine...</p>
        </div>
      </div>
    );
  }

  if (!template) {
    return (
      <div className="min-h-[70vh] flex items-center justify-center p-4">
        <div className="max-w-md w-full bg-white p-6 rounded-2xl shadow-sm border border-slate-200 text-center">
          <h2 className="text-base font-bold text-slate-900">Template Not Found</h2>
          <p className="text-xs text-slate-500 mt-1 mb-4">The requested legal template could not be loaded.</p>
          <Link href="/templates" className="text-xs font-bold text-emerald-700 underline">
            Browse All Templates
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header Breadcrumb */}
        <div className="flex flex-wrap items-center justify-between gap-4">
          <div>
            <Link
              href="/templates"
              className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-500 hover:text-emerald-700 mb-2 transition-colors"
            >
              <ArrowLeft className="w-3.5 h-3.5" /> Back to Catalog
            </Link>
            <h1 className="text-xl font-bold text-slate-900 flex items-center gap-2">
              {template.titleEn}
              <span className="font-urdu text-base font-normal text-slate-600">({template.titleUr})</span>
            </h1>
          </div>

          <div className="flex items-center gap-2">
            <span className="text-xs font-semibold px-3 py-1 bg-emerald-100 text-emerald-800 rounded-full">
              Step {currentStep} of {totalSteps}
            </span>
          </div>
        </div>

        {/* Wizard & Live Preview Split View */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
          {/* Left: Questionnaire Form */}
          <div className="lg:col-span-6 bg-white rounded-3xl p-6 shadow-sm border border-slate-200 space-y-6">
            <div>
              <div className="flex items-center justify-between mb-2">
                <h2 className="text-sm font-bold text-slate-900">
                  Step {currentStep}: Form Details
                </h2>
                <span className="text-xs text-slate-400">
                  {Math.round((currentStep / totalSteps) * 100)}% Completed
                </span>
              </div>

              {/* Progress Bar */}
              <div className="w-full h-1.5 bg-slate-100 rounded-full overflow-hidden">
                <div
                  className="h-full bg-emerald-600 rounded-full transition-all duration-300"
                  style={{ width: (currentStep / totalSteps) * 100 + "%" }}
                />
              </div>
            </div>

            {errorMsg && (
              <div className="p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-xs flex items-center gap-2">
                <AlertTriangle className="w-4 h-4 shrink-0" />
                <span>{errorMsg}</span>
              </div>
            )}

            {/* Dynamic Form Fields */}
            <div className="space-y-4">
              {currentFields.map((field) => (
                <div key={field.fieldKey} className="space-y-1.5">
                  <div className="flex items-baseline justify-between">
                    <label className="text-xs font-semibold text-slate-800">
                      {field.labelEn} {field.isRequired && <span className="text-red-500">*</span>}
                    </label>
                    <span className="text-xs font-urdu text-slate-500">{field.labelUr}</span>
                  </div>

                  {field.fieldType === "TextArea" ? (
                    <textarea
                      rows={4}
                      value={formAnswers[field.fieldKey] || ""}
                      onChange={(e) => handleInputChange(field.fieldKey, e.target.value)}
                      placeholder={field.placeholderEn || "Enter details..."}
                      className="w-full text-xs p-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                    />
                  ) : field.fieldType === "Cnic" ? (
                    <input
                      type="text"
                      maxLength={15}
                      value={formAnswers[field.fieldKey] || ""}
                      onChange={(e) => handleInputChange(field.fieldKey, formatCnic(e.target.value))}
                      placeholder={field.placeholderEn || "35201-1234567-1"}
                      className="w-full text-xs px-3 py-2.5 border border-slate-200 rounded-xl font-mono focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                    />
                  ) : field.fieldType === "Date" ? (
                    <input
                      type="date"
                      value={formAnswers[field.fieldKey] || ""}
                      onChange={(e) => handleInputChange(field.fieldKey, e.target.value)}
                      className="w-full text-xs px-3 py-2.5 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none bg-white"
                    />
                  ) : (
                    <input
                      type="text"
                      value={formAnswers[field.fieldKey] || ""}
                      onChange={(e) => handleInputChange(field.fieldKey, e.target.value)}
                      placeholder={field.placeholderEn || "Enter " + field.labelEn}
                      className="w-full text-xs px-3 py-2.5 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                    />
                  )}

                  {field.helpTextEn && (
                    <p className="text-[11px] text-slate-400">{field.helpTextEn}</p>
                  )}
                </div>
              ))}
            </div>

            {/* Navigation Buttons */}
            <div className="flex items-center justify-between pt-4 border-t border-slate-100">
              <button
                type="button"
                disabled={currentStep === 1}
                onClick={() => setCurrentStep((prev) => prev - 1)}
                className="px-4 py-2 text-xs font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 disabled:opacity-40 rounded-xl transition-colors"
              >
                Previous Step
              </button>

              <button
                type="button"
                onClick={handleNext}
                className="px-5 py-2.5 text-xs font-semibold text-white bg-emerald-700 hover:bg-emerald-800 rounded-xl shadow-sm transition-all flex items-center gap-1.5"
              >
                {currentStep === totalSteps ? (
                  <>Finalize & Generate Document <CheckCircle2 className="w-4 h-4" /></>
                ) : (
                  <>Next Step <ArrowRight className="w-4 h-4" /></>
                )}
              </button>
            </div>
          </div>

          {/* Right: Live Bilingual Preview */}
          <div className="lg:col-span-6 bg-white rounded-3xl p-6 shadow-sm border border-slate-200 space-y-4 sticky top-6">
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <div className="flex items-center gap-2">
                <Eye className="w-4 h-4 text-emerald-700" />
                <h3 className="text-xs font-bold text-slate-900">Live Bilingual Preview</h3>
              </div>

              {/* Language Selector */}
              <div className="flex bg-slate-100 p-0.5 rounded-xl text-xs font-semibold">
                <button
                  type="button"
                  onClick={() => setPreviewTab("ur")}
                  className={"px-3 py-1 rounded-lg transition-colors " + (previewTab === "ur" ? "bg-white text-emerald-800 shadow-xs" : "text-slate-500")}
                >
                  اردو (Urdu)
                </button>
                <button
                  type="button"
                  onClick={() => setPreviewTab("en")}
                  className={"px-3 py-1 rounded-lg transition-colors " + (previewTab === "en" ? "bg-white text-emerald-800 shadow-xs" : "text-slate-500")}
                >
                  English
                </button>
              </div>
            </div>

            {/* Document Preview Box */}
            <div
              className={
                "p-6 bg-slate-50/70 border border-slate-200 rounded-2xl min-h-[350px] max-h-[480px] overflow-y-auto whitespace-pre-wrap leading-relaxed " +
                (previewTab === "ur" ? "font-urdu text-sm text-right leading-loose text-slate-800" : "text-xs text-slate-700 font-serif")
              }
            >
              {renderedPreview}
            </div>

            {/* Disclaimer */}
            <div className="p-3 bg-amber-50 rounded-xl border border-amber-200 flex items-start gap-2 text-[11px] text-amber-800">
              <ShieldCheck className="w-4 h-4 shrink-0 text-amber-700 mt-0.5" />
              <span>
                <b>Statutory Notice:</b> All generated legal documents require verification and proper stamping in accordance with provincial laws of Pakistan.
              </span>
            </div>
          </div>
        </div>
      </div>

      {/* Auth Interception Modal */}
      <AuthModal
        isOpen={showAuthModal}
        onClose={() => setShowAuthModal(false)}
        onSuccess={handleFinalize}
      />

      {/* AI Assistant Floating Widget */}
      <AiLegalAssistant
        templateId={template.templateId}
        templateTitle={template.titleEn}
        contextJson={JSON.stringify(formAnswers)}
      />
    </div>
  );
}
