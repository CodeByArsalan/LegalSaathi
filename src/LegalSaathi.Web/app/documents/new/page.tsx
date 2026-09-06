"use client";

import React, { useState, useEffect, Suspense } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import Link from "next/link";
import { Scale, FileText, CheckCircle2, ArrowRight, ShieldCheck, Sparkles } from "lucide-react";
import { useAuth } from "@/lib/auth-context";
import { apiClient } from "@/lib/api-client";
import { TemplateDetail } from "@/features/templates/types";
import { DocumentDetail, GenerateDocumentResponse } from "@/features/documents/types";

function NewDocumentContent() {
  const searchParams = useSearchParams();
  const router = useRouter();
  const templateSlug = searchParams.get("template") || "general-affidavit";
  const { isAuthenticated, user } = useAuth();

  const [template, setTemplate] = useState<TemplateDetail | null>(null);
  const [isProcessing, setIsProcessing] = useState(false);
  const [statusText, setStatusText] = useState("Preparing document draft...");
  const [errorMsg, setErrorMsg] = useState("");

  useEffect(() => {
    async function initDocument() {
      if (!isAuthenticated) {
        router.push(`/auth/login?redirect=/documents/new?template=${templateSlug}`);
        return;
      }

      try {
        // 1. Fetch template
        const tRes = await apiClient.get<TemplateDetail>(`/api/templates/${templateSlug}`);
        if (!tRes.success || !tRes.data) {
          setErrorMsg("Template not found.");
          return;
        }
        setTemplate(tRes.data);

        setIsProcessing(true);
        setStatusText("Saving document in secure database...");

        // 2. Create Draft Document in Database
        const createRes = await apiClient.post<DocumentDetail>("/api/documents", {
          templateId: tRes.data.templateId,
          title: tRes.data.titleEn,
          formAnswers: {
            DeponentName: user?.fullName || "Muhammad Ali",
            Cnic: user?.cnic || "35201-1234567-1",
            AffidavitStatement: "Solemn affirmation executed for official verification purposes."
          }
        });

        if (!createRes.success || !createRes.data) {
          setErrorMsg(createRes.errors?.[0] || "Failed to create document.");
          setIsProcessing(false);
          return;
        }

        const docId = createRes.data.userDocumentId;
        setStatusText("Generating court-compliant QuestPDF & OpenXML DOCX...");

        // 3. Trigger PDF & DOCX Generation
        const genRes = await apiClient.post<GenerateDocumentResponse>(`/api/documents/${docId}/generate`, {
          language: "bilingual"
        });

        if (genRes.success) {
          setStatusText("Document generated and sealed with SHA-256 hash!");
          setTimeout(() => {
            router.push(`/documents/${docId}`);
          }, 1200);
        } else {
          setErrorMsg(genRes.errors?.[0] || "Document generation failed.");
          setIsProcessing(false);
        }
      } catch (err: any) {
        setErrorMsg(err.message || "An unexpected error occurred.");
        setIsProcessing(false);
      }
    }

    initDocument();
  }, [templateSlug, isAuthenticated, router, user]);

  return (
    <div className="min-h-[75vh] flex items-center justify-center p-4 bg-slate-50">
      <div className="max-w-md w-full bg-white p-8 rounded-2xl shadow-xl border border-slate-200 text-center">
        <div className="w-14 h-14 rounded-2xl bg-emerald-700 text-white flex items-center justify-center mx-auto mb-4 shadow-md shadow-emerald-700/20">
          <Scale className="w-7 h-7 animate-pulse" />
        </div>

        <h2 className="text-xl font-bold text-slate-900">
          {template ? template.titleEn : "Generating Legal Document"}
        </h2>
        <p className="text-sm font-nastaliq text-emerald-800 font-bold mt-1">
          دستاویز تیار کی جا رہی ہے
        </p>

        {errorMsg ? (
          <div className="mt-6 bg-rose-50 text-rose-700 border border-rose-200 p-4 rounded-xl text-xs">
            ⚠️ {errorMsg}
            <div className="mt-4">
              <Link href="/templates" className="text-emerald-700 underline font-semibold">
                Back to Templates
              </Link>
            </div>
          </div>
        ) : (
          <div className="mt-6 space-y-4">
            <div className="w-8 h-8 border-4 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto" />
            <p className="text-xs font-semibold text-slate-600 animate-pulse">{statusText}</p>
            <div className="bg-slate-50 p-3 rounded-xl text-[11px] text-slate-500 border border-slate-100 flex items-center justify-center gap-1.5">
              <ShieldCheck className="w-4 h-4 text-emerald-600" />
              <span>Cryptographic SHA-256 Tamper-Evident Stamping</span>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default function NewDocumentPage() {
  return (
    <Suspense fallback={<div className="min-h-[75vh] flex items-center justify-center">Loading...</div>}>
      <NewDocumentContent />
    </Suspense>
  );
}
