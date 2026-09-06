import React from "react";
import Link from "next/link";
import { FileQuestion, ArrowRight } from "lucide-react";

export default function NotFound() {
  return (
    <div className="min-h-[50vh] flex flex-col items-center justify-center gap-4 text-center px-4">
      <div className="w-12 h-12 rounded-full bg-slate-100 text-slate-600 flex items-center justify-center">
        <FileQuestion className="w-6 h-6" />
      </div>
      <div className="space-y-1">
        <h2 className="text-xl font-bold text-slate-900">مطلوبہ صفحہ دستیاب نہیں ہے (404)</h2>
        <p className="text-xs text-slate-500 font-sans">The page or legal template you are looking for was not found.</p>
      </div>
      <Link
        href="/"
        className="inline-flex items-center gap-2 bg-emerald-700 hover:bg-emerald-800 text-white text-xs font-semibold px-4 py-2 rounded-lg transition-colors"
      >
        <span>مرکزی صفحہ پر جائیں (Go to Homepage)</span>
        <ArrowRight className="w-3.5 h-3.5" />
      </Link>
    </div>
  );
}
