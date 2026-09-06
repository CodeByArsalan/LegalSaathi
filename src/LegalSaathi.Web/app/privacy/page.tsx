"use client";

import React from "react";
import Link from "next/link";
import { ShieldCheck, Lock, ArrowLeft, KeyRound, Server } from "lucide-react";

export default function PrivacyPolicyPage() {
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
            <div className="w-10 h-10 rounded-xl bg-emerald-50 border border-emerald-200 flex items-center justify-center text-emerald-700">
              <ShieldCheck className="w-5 h-5" />
            </div>
            <div>
              <h1 className="text-2xl font-bold text-slate-900">
                Privacy Policy & Secure Vault Data Protection
              </h1>
              <p className="font-nastaliq text-sm text-emerald-800 font-bold mt-0.5">
                ڈیٹا کے تحفظ اور رازداری کی پالیسی
              </p>
            </div>
          </div>
        </div>

        <div className="prose prose-slate max-w-none text-xs leading-relaxed space-y-6 text-slate-700 border-t border-slate-100 pt-6">
          <section className="space-y-2">
            <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2">
              <Lock className="w-4 h-4 text-emerald-700" />
              1. Information We Collect
            </h2>
            <p>
              We collect information provided directly by you when you create an account, complete questionnaire questionnaires, upload e-signatures, or request advocate reviews. This includes full legal names, CNIC numbers, phone numbers, email addresses, and specific factual questionnaire entries needed to generate court-compliant documents.
            </p>
          </section>

          <section className="space-y-2">
            <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2">
              <KeyRound className="w-4 h-4 text-emerald-700" />
              2. Pure HttpOnly Cookie Security & Zero Local Storage Exposure
            </h2>
            <p>
              Legal Saathi employs industry-standard <code>HttpOnly</code> encrypted session cookies for access and refresh tokens. Authentication tokens are never exposed to browser JavaScript (protecting against Cross-Site Scripting / XSS attacks). Documents stored in the vault are protected with tamper-evident SHA-256 integrity hashes.
            </p>
          </section>

          <section className="space-y-2">
            <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2">
              <Server className="w-4 h-4 text-emerald-700" />
              3. Data Retention & Third-Party Non-Disclosure
            </h2>
            <p>
              We do not sell, rent, or trade your personal or contractual information to marketing third parties. Document drafts and generated PDFs/Word files are accessible exclusively by your authenticated account and any verified advocate explicitly assigned to your review ticket.
            </p>
          </section>
        </div>
      </div>
    </div>
  );
}
