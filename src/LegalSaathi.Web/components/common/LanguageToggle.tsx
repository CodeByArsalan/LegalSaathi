"use client";

import React, { useState, useEffect } from "react";
import { Languages } from "lucide-react";

export function LanguageToggle() {
  const [locale, setLocale] = useState<"en" | "ur">("en");

  useEffect(() => {
    try {
      const savedLang = localStorage.getItem("legal_saathi_lang") as "en" | "ur" | null;
      if (savedLang === "ur" || savedLang === "en") {
        setLocale(savedLang);
        document.documentElement.lang = savedLang;
        document.documentElement.dir = savedLang === "ur" ? "rtl" : "ltr";
      } else {
        setLocale("en");
        document.documentElement.lang = "en";
        document.documentElement.dir = "ltr";
      }
    } catch {
      setLocale("en");
    }
  }, []);

  const toggleLocale = () => {
    const nextLocale = locale === "en" ? "ur" : "en";
    setLocale(nextLocale);
    document.documentElement.lang = nextLocale;
    document.documentElement.dir = nextLocale === "ur" ? "rtl" : "ltr";
    try {
      localStorage.setItem("legal_saathi_lang", nextLocale);
    } catch {}
  };

  return (
    <button
      type="button"
      onClick={toggleLocale}
      className="inline-flex items-center gap-2 px-3 py-1.5 text-xs font-semibold text-emerald-800 bg-emerald-50 hover:bg-emerald-100 border border-emerald-200 rounded-full transition-colors cursor-pointer"
      title={locale === "en" ? "اردو میں دیکھیں" : "Switch to English"}
    >
      <Languages className="w-3.5 h-3.5" />
      <span>{locale === "en" ? "اردو" : "English"}</span>
    </button>
  );
}
