"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { Search, FileText, ArrowRight, ShieldCheck, Scale, Sparkles, Filter, CheckCircle2 } from "lucide-react";
import { TemplateCategory, TemplateSummary } from "@/features/templates/types";
import { apiClient } from "@/lib/api-client";

export default function TemplatesCatalogPage() {
  const [categories, setCategories] = useState<TemplateCategory[]>([]);
  const [templates, setTemplates] = useState<TemplateSummary[]>([]);
  const [selectedCategory, setSelectedCategory] = useState<number | null>(null);
  const [searchQuery, setSearchQuery] = useState("");
  const [isLoading, setIsLoading] = useState(true);

  // Fallback initial data in case of development offline state
  const fallbackCategories: TemplateCategory[] = [
    { categoryId: 1, nameEn: "Personal & Family", nameUr: "ذاتی اور خاندانی", templateCount: 1, icon: "Users" },
    { categoryId: 2, nameEn: "Real Estate & Tenancy", nameUr: "جائیداد اور کرایہ داری", templateCount: 1, icon: "Home" },
    { categoryId: 3, nameEn: "Business / SME", nameUr: "کاروبار اور فری لانسنگ", templateCount: 4, icon: "Briefcase" },
    { categoryId: 4, nameEn: "Vehicles & Assets", nameUr: "گاڑیاں اور اثاثہ جات", templateCount: 1, icon: "Car" },
  ];

  const fallbackTemplates: TemplateSummary[] = [
    {
      templateId: 1,
      categoryId: 1,
      categoryNameEn: "Personal & Family",
      categoryNameUr: "ذاتی اور خاندانی",
      slug: "general-affidavit",
      titleEn: "General Affidavit (Bayan-e-Halfi)",
      titleUr: "عمومی بیان حلفی",
      descriptionEn: "Court-compliant general sworn statement of truth for official, academic, or administrative use.",
      descriptionUr: "سرکاری، تعلیمی اور انتظامی مقاصد کے لیے تصدیق شدہ عدالتی بیان حلفی۔",
      basePrice: 0,
      tier: "Free",
      requiresStampPaper: true,
      estimatedStampDuty: 100,
    },
    {
      templateId: 2,
      categoryId: 2,
      categoryNameEn: "Real Estate & Tenancy",
      categoryNameUr: "جائیداد اور کرایہ داری",
      slug: "residential-rent-agreement",
      titleEn: "Residential Rent Agreement",
      titleUr: "رہائشی کرایہ نامہ",
      descriptionEn: "Standard tenancy contract between Landlord and Tenant with rent, deposit, and maintenance terms.",
      descriptionUr: "مالک مکان اور کرایہ دار کے مابین قانونی معاہدہ مع کرایہ، سیکیورٹی ڈپازٹ اور شرائط۔",
      basePrice: 199,
      tier: "Standard",
      requiresStampPaper: true,
      estimatedStampDuty: 1200,
    },
    {
      templateId: 3,
      categoryId: 4,
      categoryNameEn: "Vehicles & Assets",
      categoryNameUr: "گاڑیاں اور اثاثہ جات",
      slug: "vehicle-sale-deed",
      titleEn: "Vehicle / Motorcycle Sale Deed",
      titleUr: "گاڑی / موٹر سائیکل کا بیع نامہ",
      descriptionEn: "Legally binding transfer and sale deed for cars, motorcycles, or commercial vehicles.",
      descriptionUr: "گاڑی یا موٹر سائیکل کی ملکیت کی منتقلی اور فروخت کا مصدقہ قانونی اقرار نامہ۔",
      basePrice: 199,
      tier: "Standard",
      requiresStampPaper: true,
      estimatedStampDuty: 100,
    },
    {
      templateId: 4,
      categoryId: 3,
      categoryNameEn: "Business / SME",
      categoryNameUr: "کاروبار اور فری لانسنگ",
      slug: "non-disclosure-agreement-nda",
      titleEn: "Non-Disclosure Agreement (NDA)",
      titleUr: "عدم افشائے راز معاہدہ (این ڈی اے)",
      descriptionEn: "Protects proprietary information, trade secrets, and client IP between business parties.",
      descriptionUr: "کاروباری رازوں اور نجی معلومات کے تحفظ کے لیے یکطرفہ یا دوطرفہ قانونی معاہدہ۔",
      basePrice: 199,
      tier: "Standard",
      requiresStampPaper: false,
      estimatedStampDuty: 0,
    },
    {
      templateId: 5,
      categoryId: 3,
      categoryNameEn: "Business / SME",
      categoryNameUr: "کاروبار اور فری لانسنگ",
      slug: "employment-contract",
      titleEn: "Full-Time Employment Contract",
      titleUr: "ملازمت کا معاہدہ",
      descriptionEn: "Statutory compliant Pakistani employment agreement covering salary, probation, notice, and leaves.",
      descriptionUr: "پاکستانی لیبر قوانین کے مطابق تنخواہ، آزمائشی مدت، اور دیگر شرائط پر مبنی ملازمت کا معاہدہ۔",
      basePrice: 499,
      tier: "Premium",
      requiresStampPaper: false,
      estimatedStampDuty: 0,
    },
    {
      templateId: 6,
      categoryId: 3,
      categoryNameEn: "Business / SME",
      categoryNameUr: "کاروبار اور فری لانسنگ",
      slug: "memorandum-of-understanding-mou",
      titleEn: "Memorandum of Understanding (MOU)",
      titleUr: "مفاہمتی یادداشت (ایم او یو)",
      descriptionEn: "Formal framework agreement establishing strategic cooperation between two organizations.",
      descriptionUr: "دو اداروں یا کمپنیوں کے درمیان باہمی تعاون اور شراکت داری کا ابتدائی خاکہ۔",
      basePrice: 499,
      tier: "Premium",
      requiresStampPaper: false,
      estimatedStampDuty: 0,
    },
    {
      templateId: 7,
      categoryId: 3,
      categoryNameEn: "Business / SME",
      categoryNameUr: "کاروبار اور فری لانسنگ",
      slug: "partnership-deed-sharakat-nama",
      titleEn: "Partnership Deed (Sharakat Nama)",
      titleUr: "شراکت داری کا معاہدہ (شراکت نامہ)",
      descriptionEn: "Comprehensive partnership deed detailing capital contribution, profit/loss ratio, and dispute resolution.",
      descriptionUr: "شراکت داروں کے درمیان سرمائے کی فراہمی، نفع و نقصان کی تقسیم اور شرائط پر مبنی شراکت نامہ۔",
      basePrice: 499,
      tier: "Premium",
      requiresStampPaper: true,
      estimatedStampDuty: 2000,
    },
  ];

  useEffect(() => {
    async function loadData() {
      setIsLoading(true);
      try {
        const [catRes, tempRes] = await Promise.all([
          apiClient.get<TemplateCategory[]>("/api/templates/categories").catch(() => null),
          apiClient.get<TemplateSummary[]>("/api/templates").catch(() => null),
        ]);

        if (catRes?.success && catRes.data) {
          setCategories(catRes.data);
        } else {
          setCategories(fallbackCategories);
        }

        if (tempRes?.success && tempRes.data) {
          setTemplates(tempRes.data);
        } else {
          setTemplates(fallbackTemplates);
        }
      } catch {
        setCategories(fallbackCategories);
        setTemplates(fallbackTemplates);
      } finally {
        setIsLoading(false);
      }
    }
    loadData();
  }, []);

  const filteredTemplates = templates.filter((t) => {
    const matchesCategory = selectedCategory === null || t.categoryId === selectedCategory;
    const matchesSearch =
      searchQuery.trim() === "" ||
      t.titleEn.toLowerCase().includes(searchQuery.toLowerCase()) ||
      t.titleUr.includes(searchQuery) ||
      (t.descriptionEn && t.descriptionEn.toLowerCase().includes(searchQuery.toLowerCase())) ||
      (t.descriptionUr && t.descriptionUr.includes(searchQuery));
    return matchesCategory && matchesSearch;
  });

  return (
    <div className="min-h-screen bg-slate-50 py-10 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Header Banner */}
        <div className="text-center max-w-3xl mx-auto mb-10">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-100/80 border border-emerald-200 text-emerald-800 text-xs font-semibold mb-3">
            <Scale className="w-3.5 h-3.5" />
            <span>Verified Pakistani Legal Templates / مصدقہ قانونی دستاویزات</span>
          </div>
          <h1 className="text-3xl sm:text-4xl font-extrabold text-slate-900 tracking-tight">
            Legal Document Templates Library
          </h1>
          <p className="text-lg font-nastaliq text-emerald-800 font-bold mt-2">
            عدالتی اور قانونی طور پر تسلیم شدہ دستاویزات کا مکمل ذخیرہ
          </p>
          <p className="text-sm text-slate-600 mt-2">
            Select a template below to start the dynamic step-by-step questionnaire with real-time bilingual preview.
          </p>
        </div>

        {/* Search & Category Filter Bar */}
        <div className="bg-white p-4 rounded-2xl shadow-sm border border-slate-200 mb-8 space-y-4">
          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
              <Search className="w-5 h-5" />
            </div>
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search templates e.g. Affidavit, Rent Agreement, NDA, بیع نامہ, کرایہ نامہ..."
              className="block w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition-all"
            />
          </div>

          {/* Category Tabs */}
          <div className="flex items-center gap-2 overflow-x-auto pb-1 text-xs font-semibold scrollbar-thin">
            <button
              onClick={() => setSelectedCategory(null)}
              className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all flex items-center gap-1.5 cursor-pointer ${
                selectedCategory === null
                  ? "bg-emerald-700 text-white shadow-sm font-bold"
                  : "bg-slate-100 text-slate-700 hover:bg-slate-200"
              }`}
            >
              <span>All Templates / تمام دستاویزات</span>
              <span className="px-1.5 py-0.5 rounded-full bg-black/10 text-[10px]">
                {templates.length}
              </span>
            </button>
            {categories.map((cat) => (
              <button
                key={cat.categoryId}
                onClick={() => setSelectedCategory(cat.categoryId)}
                className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all flex items-center gap-1.5 cursor-pointer ${
                  selectedCategory === cat.categoryId
                    ? "bg-emerald-700 text-white shadow-sm font-bold"
                    : "bg-slate-100 text-slate-700 hover:bg-slate-200"
                }`}
              >
                <span>{cat.nameEn}</span>
                <span className="font-nastaliq text-[11px] text-emerald-900 font-bold">
                  ({cat.nameUr})
                </span>
              </button>
            ))}
          </div>
        </div>

        {/* Templates Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredTemplates.map((template) => (
            <div
              key={template.slug}
              className="bg-white rounded-2xl p-6 shadow-sm hover:shadow-md border border-slate-200 transition-all flex flex-col justify-between group"
            >
              <div>
                {/* Header meta */}
                <div className="flex items-center justify-between gap-2 mb-3">
                  <span className="text-[11px] font-semibold text-emerald-800 bg-emerald-50 border border-emerald-200/60 px-2.5 py-1 rounded-lg">
                    {template.categoryNameEn}
                  </span>
                  <div className="flex items-center gap-1.5">
                    {template.tier === "Free" ? (
                      <span className="text-[10px] font-bold text-emerald-700 bg-emerald-100 px-2 py-0.5 rounded-md">
                        FREE
                      </span>
                    ) : (
                      <span className="text-[10px] font-bold text-slate-700 bg-slate-100 px-2 py-0.5 rounded-md">
                        PKR {template.basePrice}
                      </span>
                    )}
                  </div>
                </div>

                {/* Title */}
                <h3 className="text-base font-bold text-slate-900 group-hover:text-emerald-700 transition-colors">
                  {template.titleEn}
                </h3>
                <h4 className="text-sm font-nastaliq font-bold text-emerald-800 mt-1">
                  {template.titleUr}
                </h4>

                {/* Description */}
                <p className="text-xs text-slate-600 mt-2.5 line-clamp-2 leading-relaxed">
                  {template.descriptionEn}
                </p>
                <p className="text-xs font-nastaliq text-slate-500 mt-1 line-clamp-1">
                  {template.descriptionUr}
                </p>

                {/* Stamp paper duty indicator */}
                {template.requiresStampPaper && (
                  <div className="mt-4 pt-3 border-t border-slate-100 flex items-center justify-between text-[11px] text-amber-800 bg-amber-50/60 px-3 py-1.5 rounded-lg">
                    <span>Requires Stamp Paper (اسٹامپ پیپر)</span>
                    <span className="font-bold">~PKR {template.estimatedStampDuty}</span>
                  </div>
                )}
              </div>

              {/* Action */}
              <div className="mt-6 pt-4 border-t border-slate-100 flex items-center justify-between">
                <div className="flex items-center gap-1 text-[11px] text-slate-500">
                  <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
                  <span>Court Ready</span>
                </div>
                <Link
                  href={`/templates/${template.slug}`}
                  className="inline-flex items-center gap-1.5 text-xs font-bold text-white bg-emerald-700 hover:bg-emerald-800 px-4 py-2 rounded-xl transition-all shadow-sm"
                >
                  <span>Start Drafting</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </div>
            </div>
          ))}
        </div>

        {filteredTemplates.length === 0 && (
          <div className="text-center py-16 bg-white rounded-2xl border border-slate-200">
            <FileText className="w-12 h-12 text-slate-300 mx-auto mb-3" />
            <h3 className="text-base font-bold text-slate-800">No templates found</h3>
            <p className="text-xs text-slate-500 mt-1">
              Try adjusting your search keywords or selecting another category.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
