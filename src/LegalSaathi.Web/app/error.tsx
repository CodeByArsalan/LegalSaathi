"use client";

import React, { useEffect } from "react";
import { AlertTriangle, RefreshCw } from "lucide-react";

export default function ErrorPage({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error("Legal Saathi UI Error:", error);
  }, [error]);

  return (
    <div className="min-h-[50vh] flex flex-col items-center justify-center gap-4 text-center px-4">
      <div className="w-12 h-12 rounded-full bg-red-100 text-red-600 flex items-center justify-center">
        <AlertTriangle className="w-6 h-6" />
      </div>
      <div className="space-y-1">
        <h2 className="text-xl font-bold text-slate-900">کوئی غیر متوقع مسئلہ پیش آیا ہے</h2>
        <p className="text-xs text-slate-500 font-sans">An unexpected error occurred. Please try again.</p>
      </div>
      <button
        type="button"
        onClick={() => reset()}
        className="inline-flex items-center gap-2 bg-emerald-700 hover:bg-emerald-800 text-white text-xs font-semibold px-4 py-2 rounded-lg transition-colors"
      >
        <RefreshCw className="w-3.5 h-3.5" />
        <span>دوبارہ کوشش کریں (Retry)</span>
      </button>
    </div>
  );
}
