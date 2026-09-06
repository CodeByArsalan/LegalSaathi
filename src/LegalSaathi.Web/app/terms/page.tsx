"use client";

import React from "react";
import Link from "next/link";
import { FileCheck, ArrowLeft, Check, Scale } from "lucide-react";

export default function TermsOfServicePage() {
  return (
    <div className="min-h-screen bg-slate-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto bg-white rounded-3xl p-8 sm:p-12 shadow-sm border border-slate-200 space-y-8">
        <div>
          <Link
            href="/"
            className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-500 hover:text-emerald-700 mb-4 transition-colors"
          >
            <ArrowLeft className="w-3.5 h-3.5" /> Back to Home
          </Link>
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-blue-50 border border-blue-200 flex items-center justify-center text-blue-700">
              <FileCheck className="w-5 h-5" />
            </div>
            <div>
              <h1 className="text-2xl font-bold text-slate-900">
                Terms of Service & DIY Generation Agreement
              </h1>
              <p className="font-nastaliq text-sm text-emerald-800 font-bold mt-0.5">
                خدمات کے استعمال کے قانونی ضوابط
              </p>
            </div>
          </div>
        </div>

        <div className="prose prose-slate max-w-none text-xs leading-relaxed space-y-6 text-slate-700 border-t border-slate-100 pt-6">
          <section className="space-y-2">
            <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2">
              <Scale className="w-4 h-4 text-emerald-700" />
              1. Acceptance of Terms
            </h2>
            <p>
              By creating an account, generating legal templates, utilizing digital signatures, or interacting with the AI Legal Assistant on Legal Saathi, you agree to be bound by these Terms of Service in accordance with the laws of the Islamic Republic of Pakistan.
            </p>
          </section>

          <section className="space-y-2">
            <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2">
              <Check className="w-4 h-4 text-emerald-700" />
              2. Accuracy of Sworn Information
            </h2>
            <p>
              You certify that all CNIC numbers, addresses, names, and factual statements entered into document questionnaires are true and accurate. Submitting knowingly false statements in legal affidavits is punishable under Section 193 of the Pakistan Penal Code 1860.
            </p>
          </section>

          <section className="space-y-2">
            <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2">
              <FileCheck className="w-4 h-4 text-emerald-700" />
              3. Intellectual Property
            </h2>
            <p>
              The bilingual legal drafting engines, QuestPDF document renderers, AI statutory classifiers, and platform designs are proprietary intellectual property of Nexvora Technologies. Users receive a perpetual, non-exclusive license to use and execute documents generated for personal or commercial affairs.
            </p>
          </section>
        </div>
      </div>
    </div>
  );
}
