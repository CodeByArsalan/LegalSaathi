"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  FileText,
  Plus,
  Download,
  Eye,
  CheckCircle2,
  Clock,
  ShieldCheck,
  Scale,
  Sparkles,
  ArrowRight
} from "lucide-react";
import { useAuth } from "@/lib/auth-context";
import { apiClient } from "@/lib/api-client";
import { DocumentSummary } from "@/features/documents/types";

export default function UserDashboardPage() {
  const { isAuthenticated, user, isLoading: authLoading } = useAuth();
  const router = useRouter();
  const [documents, setDocuments] = useState<DocumentSummary[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    if (!authLoading && !isAuthenticated) {
      router.push("/auth/login?redirect=/dashboard");
      return;
    }

    async function loadDocuments() {
      setIsLoading(true);
      try {
        const res = await apiClient.get<DocumentSummary[]>("/api/documents");
        if (res.success && res.data) {
          setDocuments(res.data);
        }
      } catch (err) {
        console.error("Failed to load documents", err);
      } finally {
        setIsLoading(false);
      }
    }

    if (isAuthenticated) {
      loadDocuments();
    }
  }, [isAuthenticated, authLoading, router]);

  const getStatusBadge = (status: string) => {
    switch (status) {
      case "Completed":
        return (
          <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-800">
            <CheckCircle2 className="w-3 h-3" /> Completed
          </span>
        );
      case "Signed":
        return (
          <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-blue-100 text-blue-800">
            <ShieldCheck className="w-3 h-3" /> Digitally Signed
          </span>
        );
      case "UnderLawyerReview":
        return (
          <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-800">
            <Clock className="w-3 h-3" /> Under Review
          </span>
        );
      default:
        return (
          <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-slate-100 text-slate-700">
            <FileText className="w-3 h-3" /> Draft
          </span>
        );
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 py-10 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto space-y-8">
        {/* User Welcome Banner */}
        <div className="bg-gradient-to-r from-emerald-800 to-emerald-950 text-white rounded-3xl p-6 sm:p-8 shadow-lg flex flex-col md:flex-row items-start md:items-center justify-between gap-6">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/10 text-emerald-200 text-xs font-medium">
              <Scale className="w-3.5 h-3.5" />
              <span>Legal Saathi Dashboard / ڈیش بورڈ</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight">
              Welcome back, {user?.fullName || "User"}
            </h1>
            <p className="text-xs text-emerald-100 font-nastaliq font-bold">
              آپ کے تمام مصدقہ اور ڈرافٹ شدہ قانونی دستاویزات کی فہرست
            </p>
          </div>

          <Link
            href="/templates"
            className="inline-flex items-center gap-2 px-5 py-3 rounded-xl bg-white text-emerald-900 font-bold text-xs shadow-sm hover:bg-emerald-50 transition-all cursor-pointer whitespace-nowrap"
          >
            <Plus className="w-4 h-4" />
            <span>Create New Document / نئی دستاویز بنائیں</span>
          </Link>
        </div>

        {/* Documents Table / Grid */}
        <div className="bg-white rounded-2xl shadow-sm border border-slate-200 p-6">
          <div className="flex items-center justify-between mb-6 pb-4 border-b border-slate-100">
            <div>
              <h2 className="text-lg font-bold text-slate-900">My Legal Documents</h2>
              <p className="text-xs text-slate-500">Manage, preview, and download your court-compliant documents</p>
            </div>
            <span className="text-xs font-semibold px-2.5 py-1 rounded-lg bg-slate-100 text-slate-700">
              Total: {documents.length}
            </span>
          </div>

          {isLoading ? (
            <div className="py-12 text-center text-slate-500 text-sm">
              <div className="w-8 h-8 border-4 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto mb-3" />
              <span>Loading documents...</span>
            </div>
          ) : documents.length === 0 ? (
            <div className="py-16 text-center">
              <FileText className="w-12 h-12 text-slate-300 mx-auto mb-3" />
              <h3 className="text-sm font-bold text-slate-800">No documents created yet</h3>
              <p className="text-xs text-slate-500 mt-1 mb-4">
                Choose a template from our library to generate your first document in minutes.
              </p>
              <Link
                href="/templates"
                className="inline-flex items-center gap-1.5 px-4 py-2 rounded-xl bg-emerald-700 text-white text-xs font-bold hover:bg-emerald-800 shadow-sm"
              >
                <span>Browse Templates</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs">
                <thead>
                  <tr className="border-b border-slate-200 text-slate-500 font-semibold bg-slate-50/50">
                    <th className="py-3 px-4">Document Title</th>
                    <th className="py-3 px-4">Status</th>
                    <th className="py-3 px-4">Created Date</th>
                    <th className="py-3 px-4">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {documents.map((doc) => (
                    <tr key={doc.userDocumentId} className="hover:bg-slate-50/60 transition-colors">
                      <td className="py-3.5 px-4">
                        <Link
                          href={`/documents/${doc.userDocumentId}`}
                          className="font-bold text-slate-900 hover:text-emerald-700 transition-colors block"
                        >
                          {doc.title || doc.templateTitleEn}
                        </Link>
                        <span className="font-nastaliq text-[11px] text-emerald-800 block">
                          {doc.templateTitleUr}
                        </span>
                        <span className="text-[10px] text-slate-400 font-mono">
                          LS-{doc.documentGuid.slice(0, 8).toUpperCase()}
                        </span>
                      </td>
                      <td className="py-3.5 px-4">{getStatusBadge(doc.status)}</td>
                      <td className="py-3.5 px-4 text-slate-600">
                        {new Date(doc.createdAt).toLocaleDateString("en-PK", {
                          day: "numeric",
                          month: "short",
                          year: "numeric",
                        })}
                      </td>
                      <td className="py-3.5 px-4">
                        <div className="flex items-center gap-2">
                          <Link
                            href={`/documents/${doc.userDocumentId}`}
                            className="p-1.5 rounded-lg border border-slate-200 hover:bg-slate-100 text-slate-700 font-semibold text-xs flex items-center gap-1"
                            title="View Document"
                          >
                            <Eye className="w-3.5 h-3.5" />
                            <span>View</span>
                          </Link>
                          <a
                            href={`/api/documents/${doc.userDocumentId}/download/pdf`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="p-1.5 rounded-lg bg-emerald-50 hover:bg-emerald-100 text-emerald-800 font-semibold text-xs flex items-center gap-1"
                            title="Download PDF"
                          >
                            <Download className="w-3.5 h-3.5" />
                            <span>PDF</span>
                          </a>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
