"use client";

import React, { useState, useEffect } from "react";
import { Languages } from "lucide-react";

export function LanguageToggle() {
  const [locale, setLocale] = useState<"ur" | "en">("ur");

  useEffect(() => {
    const currentLang = document.documentElement.lang as "ur" | "en";
    if (currentLang === "ur" || currentLang === "en") {
      setLocale(currentLang);
    }
  }, []);

  const toggleLocale = () => {
    const nextLocale = locale === "ur" ? "en" : "ur";
    setLocale(nextLocale);
    document.documentElement.lang = nextLocale;
    document.documentElement.dir = nextLocale === "ur" ? "rtl" : "ltr";
  };

  return (
    <button
      type="button"
      onClick={toggleLocale}
      className="inline-flex items-center gap-2 px-3 py-1.5 text-xs font-semibold text-emerald-800 bg-emerald-50 hover:bg-emerald-100 border border-emerald-200 rounded-full transition-colors"
      title={locale === "ur" ? "Switch to English" : "اردو میں دیکھیں"}
    >
      <Languages className="w-3.5 h-3.5" />
      <span>{locale === "ur" ? "English" : "اردو"}</span>
    </button>
  );
}
