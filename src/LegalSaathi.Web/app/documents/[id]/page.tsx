"use client";

import React, { useState, useEffect } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import {
  FileText,
  Download,
  ShieldCheck,
  CheckCircle2,
  Clock,
  ArrowLeft,
  Lock,
  Scale,
  Sparkles,
  ExternalLink,
  Copy,
  Check,
  PenTool,
  CheckCheck
} from "lucide-react";
import { useAuth } from "@/lib/auth-context";
import { apiClient } from "@/lib/api-client";
import { DocumentDetail } from "@/features/documents/types";
import { SignatureModal } from "@/components/signature/SignatureModal";
import { AiLegalAssistant } from "@/components/ai/AiLegalAssistant";
import { APP_CONFIG, ROUTES } from "@/lib/constants";

interface SignatureRecord {
  signatureId: number;
  signerName: string;
  signerCnic: string;
  signerRole: string;
  signerEmail?: string;
  signerPhone?: string;
  signatureUri: string;
  isOtpVerified: boolean;
  signedAt: string;
}

export default function DocumentDetailsPage() {
  const params = useParams();
  const router = useRouter();
  const documentId = params.id as string;
  const { isAuthenticated, isLoading: authLoading } = useAuth();

  const [document, setDocument] = useState<DocumentDetail | null>(null);
  const [signatures, setSignatures] = useState<SignatureRecord[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [copiedHash, setCopiedHash] = useState(false);
  const [isSignModalOpen, setIsSignModalOpen] = useState(false);

  const loadDocument = async () => {
    setIsLoading(true);
    try {
      const res = await apiClient.get<DocumentDetail>("/api/documents/" + documentId);
      if (res.success && res.data) {
        setDocument(res.data);
      }

      // Load signatures
      const sigRes = await apiClient.get<SignatureRecord[]>("/api/documents/" + documentId + "/signatures");
      if (sigRes.success && sigRes.data) {
        setSignatures(sigRes.data);
      }
    } catch (err) {
      console.error("Failed to load document", err);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    if (!authLoading && !isAuthenticated) {
      router.push("/auth/login?redirect=/documents/" + documentId);
      return;
    }

    if (isAuthenticated) {
      loadDocument();
    }
  }, [documentId, isAuthenticated, authLoading, router]);

  const copyHashToClipboard = () => {
    if (document?.documentHash) {
      navigator.clipboard.writeText(document.documentHash);
      setCopiedHash(true);
      setTimeout(() => setCopiedHash(false), 2000);
    }
  };

  if (isLoading) {
    return (
      <div className="min-h-[70vh] flex items-center justify-center">
        <div className="text-center space-y-3">
          <div className="w-8 h-8 border-4 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto" />
          <p className="text-xs text-slate-500 font-medium">Loading document vault...</p>
        </div>
      </div>
    );
  }

  if (!document) {
    return (
      <div className="min-h-[70vh] flex items-center justify-center p-4">
        <div className="max-w-md w-full bg-white p-6 rounded-2xl shadow-sm border border-slate-200 text-center">
          <h2 className="text-base font-bold text-slate-900">Document Not Found</h2>
          <p className="text-xs text-slate-500 mt-1 mb-4">This document does not exist or access was denied.</p>
          <Link href="/dashboard" className="text-xs font-bold text-emerald-700 underline">
            Return to Dashboard
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header Breadcrumb */}
        <div className="flex flex-wrap items-center justify-between gap-4">
          <div>
            <Link
              href="/dashboard"
              className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-500 hover:text-emerald-700 mb-2 transition-colors"
            >
              <ArrowLeft className="w-3.5 h-3.5" /> Back to Dashboard
            </Link>
            <h1 className="text-xl font-bold text-slate-900 flex items-center gap-2">
              {document.title}
              <span className="text-xs px-2.5 py-0.5 rounded-full font-semibold bg-emerald-100 text-emerald-800">
                {document.status}
              </span>
            </h1>
            <p className="text-xs text-slate-500 mt-0.5">
              Template: {document.templateTitleEn} • Created: {new Date(document.createdAt).toLocaleDateString()}
            </p>
          </div>

          <div className="flex flex-wrap items-center gap-2.5">
            {/* E-Signature CTA */}
            <button
              onClick={() => setIsSignModalOpen(true)}
              className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-semibold bg-slate-900 text-white hover:bg-slate-800 shadow-sm transition-all"
            >
              <PenTool className="w-3.5 h-3.5 text-emerald-400" /> Digitally Sign
            </button>

            {/* Download PDF */}
            <a
              href={`${APP_CONFIG.apiBaseUrl}/documents/${document.userDocumentId}/download/pdf`}
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-semibold bg-emerald-700 text-white hover:bg-emerald-800 shadow-sm transition-all"
            >
              <Download className="w-3.5 h-3.5" /> Download PDF
            </a>

            {/* Download Word DOCX */}
            <a
              href={`${APP_CONFIG.apiBaseUrl}/documents/${document.userDocumentId}/download/docx`}
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-semibold bg-white border border-slate-300 text-slate-700 hover:bg-slate-50 shadow-sm transition-all"
            >
              <FileText className="w-3.5 h-3.5 text-blue-600" /> Download Word (.docx)
            </a>
          </div>
        </div>

        {/* Cryptographic SHA-256 Stamp Banner */}
        {document.documentHash && (
          <div className="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm flex flex-wrap items-center justify-between gap-3">
            <div className="flex items-center gap-3">
              <div className="w-9 h-9 rounded-xl bg-emerald-50 border border-emerald-200 flex items-center justify-center text-emerald-700 shrink-0">
                <ShieldCheck className="w-5 h-5" />
              </div>
              <div>
                <div className="flex items-center gap-2">
                  <h4 className="text-xs font-bold text-slate-900">Tamper-Evident SHA-256 Integrity Seal</h4>
                  <span className="text-[10px] bg-emerald-100 text-emerald-800 px-2 py-0.5 rounded font-mono font-bold">
                    ETO 2002 Compliant
                  </span>
                </div>
                <p className="text-[11px] font-mono text-slate-500 truncate max-w-lg mt-0.5">
                  {document.documentHash}
                </p>
              </div>
            </div>

            <button
              onClick={copyHashToClipboard}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-lg transition-colors"
            >
              {copiedHash ? (
                <>
                  <Check className="w-3.5 h-3.5 text-emerald-600" /> Copied
                </>
              ) : (
                <>
                  <Copy className="w-3.5 h-3.5 text-slate-500" /> Copy Hash
                </>
              )}
            </button>
          </div>
        )}

        {/* Main Content Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Document Summary & Signatures */}
          <div className="lg:col-span-2 space-y-6">
            {/* Signatures Card */}
            <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-sm font-bold text-slate-900 flex items-center gap-2">
                  <PenTool className="w-4 h-4 text-emerald-700" />
                  Recorded Digital Signatures ({signatures.length})
                </h3>
                <button
                  onClick={() => setIsSignModalOpen(true)}
                  className="text-xs font-bold text-emerald-700 hover:underline"
                >
                  + Add Signature
                </button>
              </div>

              {signatures.length === 0 ? (
                <div className="p-6 bg-slate-50 rounded-2xl border border-dashed border-slate-300 text-center space-y-2">
                  <PenTool className="w-6 h-6 text-slate-400 mx-auto" />
                  <p className="text-xs font-semibold text-slate-700">No signatures attached yet</p>
                  <p className="text-[11px] text-slate-500">
                    Digitally sign this document with OTP authorization under Pakistan ETO 2002.
                  </p>
                  <button
                    onClick={() => setIsSignModalOpen(true)}
                    className="mt-2 inline-flex items-center gap-1 text-xs font-bold text-white bg-slate-900 px-3.5 py-1.5 rounded-xl shadow-sm hover:bg-slate-800 transition-colors"
                  >
                    Sign Now
                  </button>
                </div>
              ) : (
                <div className="space-y-3">
                  {signatures.map((sig) => (
                    <div
                      key={sig.signatureId}
                      className="p-3.5 bg-slate-50 rounded-2xl border border-slate-200 flex flex-wrap items-center justify-between gap-3"
                    >
                      <div className="flex items-center gap-3">
                        <div className="w-8 h-8 rounded-xl bg-emerald-100 flex items-center justify-center text-emerald-800 font-bold text-xs">
                          <CheckCheck className="w-4 h-4" />
                        </div>
                        <div>
                          <div className="flex items-center gap-2">
                            <h4 className="text-xs font-bold text-slate-900">{sig.signerName}</h4>
                            <span className="text-[10px] bg-slate-200 text-slate-700 px-1.5 py-0.5 rounded font-medium">
                              {sig.signerRole}
                            </span>
                          </div>
                          <p className="text-[11px] text-slate-500 font-mono">
                            CNIC: {sig.signerCnic} • Signed: {new Date(sig.signedAt).toLocaleString()}
                          </p>
                        </div>
                      </div>

                      <div className="flex items-center gap-2">
                        {sig.isOtpVerified && (
                          <span className="text-[10px] font-semibold bg-emerald-100 text-emerald-800 px-2 py-0.5 rounded-full flex items-center gap-1">
                            <ShieldCheck className="w-3 h-3" /> OTP Verified
                          </span>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Document Form Data Card */}
            <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm">
              <h3 className="text-sm font-bold text-slate-900 mb-4 flex items-center gap-2">
                <FileText className="w-4 h-4 text-emerald-700" />
                Submitted Document Details
              </h3>

              <div className="bg-slate-50 rounded-2xl p-4 border border-slate-200">
                <pre className="text-xs font-mono text-slate-700 whitespace-pre-wrap">
                  {JSON.stringify(JSON.parse(document.formAnswersJson || "{}"), null, 2)}
                </pre>
              </div>
            </div>
          </div>

          {/* Right Sidebar */}
          <div className="space-y-6">
            {/* Vault Security Card */}
            <div className="bg-gradient-to-br from-slate-900 to-slate-800 text-white rounded-3xl p-6 shadow-xl border border-slate-700 space-y-4">
              <div className="flex items-center gap-2.5">
                <div className="w-8 h-8 rounded-xl bg-emerald-500/20 flex items-center justify-center text-emerald-400">
                  <Lock className="w-4 h-4" />
                </div>
                <div>
                  <h4 className="text-xs font-bold">Secure Document Vault</h4>
                  <p className="text-[10px] text-slate-400">GUID: {document.documentGuid}</p>
                </div>
              </div>

              <p className="text-xs text-slate-300 leading-relaxed">
                This document is stored in the Legal Saathi encrypted vault with automated versioning and legal integrity hashing.
              </p>

              <div className="p-3 bg-white/5 rounded-2xl border border-white/10 space-y-1.5 text-[11px]">
                <div className="flex justify-between text-slate-300">
                  <span>Status:</span>
                  <span className="font-semibold text-emerald-400">{document.status}</span>
                </div>
                <div className="flex justify-between text-slate-300">
                  <span>Access:</span>
                  <span className="font-semibold text-white">Full Vault Access</span>
                </div>
              </div>
            </div>

            {/* Lawyer Review Card */}
            <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm space-y-3">
              <div className="flex items-center gap-2 text-slate-900 font-bold text-xs">
                <Scale className="w-4 h-4 text-emerald-700" />
                <span>Verified Lawyer Review</span>
              </div>
              <p className="text-xs text-slate-500 leading-relaxed">
                Have a verified High Court advocate review your drafted document, add legal stamps, and verify court compliance.
              </p>
              <button
                onClick={() => router.push(`/lawyer-review?docId=${document.userDocumentId}&tab=submit`)}
                className="w-full py-2.5 bg-emerald-50 hover:bg-emerald-100 text-emerald-800 font-semibold text-xs rounded-xl border border-emerald-200 transition-colors"
              >
                Request Lawyer Review
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Signature Modal */}
      <SignatureModal
        isOpen={isSignModalOpen}
        onClose={() => setIsSignModalOpen(false)}
        documentId={document.userDocumentId}
        documentTitle={document.title}
        onSignedSuccess={loadDocument}
      />

      {/* AI Assistant Floating Widget */}
      <AiLegalAssistant
        documentId={document.userDocumentId}
        templateId={document.templateId}
        templateTitle={document.templateTitleEn}
        contextJson={document.formAnswersJson}
      />
    </div>
  );
}
