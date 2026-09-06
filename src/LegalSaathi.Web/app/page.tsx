import React from "react";
import Link from "next/link";
import { 
  FileText, 
  Home, 
  Briefcase, 
  Car, 
  ShieldCheck, 
  Sparkles, 
  CheckCircle2, 
  Zap, 
  ArrowRight,
  Clock,
  Coins
} from "lucide-react";
import { ThemeBadge } from "@/components/common/ThemeBadge";

export default function HomePage() {
  const categories = [
    {
      id: 1,
      nameEn: "Personal & Family",
      nameUr: "ذاتی اور خاندانی",
      descEn: "Bayan-e-Halfi, Lost CNIC / Degree affidavits, Power of Attorney (Mukhtar Nama).",
      descUr: "عمومی بیان حلفی، گمشدگی شناختی کارڈ / ڈگری، اور عمومی و خاص مختار نامے۔",
      icon: FileText,
      color: "from-blue-600 to-indigo-700",
      count: "5+ Templates",
      slug: "personal",
    },
    {
      id: 2,
      nameEn: "Real Estate & Tenancy",
      nameUr: "جائیداد اور کرایہ داری",
      descEn: "Residential & Commercial Leases, Plot/House Bayana Token, Tenancy Vacation Notices.",
      descUr: "رہائشی و تجارتی کرایہ نامہ، پلاٹ/مکان بیعانہ رسید، اور کرایہ داری بے دخلی نوٹس۔",
      icon: Home,
      color: "from-emerald-600 to-teal-700",
      count: "4+ Templates",
      slug: "real-estate",
    },
    {
      id: 3,
      nameEn: "Business & Freelancing",
      nameUr: "کاروبار اور فری لانسنگ",
      descEn: "NDAs, Freelancer Agreements, Employment Contracts, MOUs, Partnership Deeds.",
      descUr: "این ڈی اے، فری لانس معاہدے، ملازمتی معاہدے، اور شراکت داری نامے۔",
      icon: Briefcase,
      color: "from-amber-600 to-orange-700",
      count: "5+ Templates",
      slug: "business",
    },
    {
      id: 4,
      nameEn: "Vehicles & Assets",
      nameUr: "گاڑیاں اور اثاثہ جات",
      descEn: "Car / Bike Sale Deeds, Delivery Receipts, Promissory Notes (Iqrar Nama).",
      descUr: "گاڑی / موٹر سائیکل کا بیع نامہ، وصولی رسید، اور مالی اقرار نامے۔",
      icon: Car,
      color: "from-purple-600 to-violet-700",
      count: "4+ Templates",
      slug: "vehicles",
    },
  ];

  return (
    <div className="space-y-16 py-8">
      {/* Hero Section */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-6">
        <div className="inline-flex items-center gap-2">
          <ThemeBadge variant="gold">
            <Sparkles className="w-3.5 h-3.5" />
            <span>The TurboTax + LegalZoom of Pakistan</span>
          </ThemeBadge>
        </div>

        <h1 className="text-3xl sm:text-5xl font-extrabold text-slate-900 tracking-tight leading-tight max-w-4xl mx-auto">
          عدالتی معیار کے قانونی دستاویزات اب صرف <span className="text-emerald-700">5 منٹ</span> میں
          <span className="block text-2xl sm:text-3xl font-bold text-slate-600 mt-2 font-sans">
            Court-Compliant Legal Documents in Minutes
          </span>
        </h1>

        <p className="text-slate-600 max-w-2xl mx-auto text-sm sm:text-base leading-relaxed">
          لیگل ساتھی کے ذریعے اردو اور انگریزی میں تصدیق شدہ معاہدات بنائیں، ڈیجیٹل دستخط کریں اور بآسانی ڈاؤنلوڈ کریں۔
          <span className="block text-xs sm:text-sm text-slate-500 mt-1 font-sans">
            Bilingual (Urdu Nastaliq & English) generation complying with ETO 2002 & Provincial e-Stamp requirements.
          </span>
        </p>

        {/* Speed / Pricing Pill Comparison */}
        <div className="inline-flex flex-wrap items-center justify-center gap-4 py-2 px-4 bg-white border border-slate-200 rounded-2xl shadow-sm text-xs text-slate-700">
          <div className="flex items-center gap-1.5 text-emerald-700 font-semibold">
            <Zap className="w-4 h-4" />
            <span>Sub-3s Generation</span>
          </div>
          <span className="text-slate-300">|</span>
          <div className="flex items-center gap-1.5 text-slate-700">
            <Clock className="w-4 h-4 text-emerald-600" />
            <span>From 3-5 Days → <strong>5 Mins</strong></span>
          </div>
          <span className="text-slate-300">|</span>
          <div className="flex items-center gap-1.5 text-slate-700">
            <Coins className="w-4 h-4 text-amber-500" />
            <span>From Rs. 5,000 → <strong>Free / Rs. 199</strong></span>
          </div>
        </div>

        <div className="flex flex-wrap items-center justify-center gap-4 pt-4">
          <Link
            href="/templates"
            className="inline-flex items-center gap-2 bg-emerald-700 hover:bg-emerald-800 text-white font-semibold px-6 py-3 rounded-xl shadow-md transition-all hover:scale-105"
          >
            <span>دستاویز کا انتخاب کریں (Browse Templates)</span>
            <ArrowRight className="w-4 h-4" />
          </Link>
          <Link
            href="/ai-assistant"
            className="inline-flex items-center gap-2 bg-white hover:bg-slate-50 text-slate-800 font-semibold px-6 py-3 rounded-xl border border-slate-300 shadow-sm transition-all"
          >
            <Sparkles className="w-4 h-4 text-amber-500" />
            <span>AI وکیل سے مشورہ (Legal Assistant)</span>
          </Link>
        </div>
      </section>

      {/* Category Grid */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-6">
        <div className="text-center space-y-1">
          <h2 className="text-2xl font-bold text-slate-900">دستاویزات کی کیٹیگریز (Document Categories)</h2>
          <p className="text-xs text-slate-500">Select a category to start your guided legal questionnaire</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {categories.map((cat) => {
            const Icon = cat.icon;
            return (
              <Link
                key={cat.id}
                href={`/templates/${cat.slug}`}
                className="group p-6 bg-white rounded-2xl border border-slate-200 hover:border-emerald-500 shadow-sm hover:shadow-md transition-all flex flex-col justify-between space-y-4"
              >
                <div className="space-y-3">
                  <div className={`w-12 h-12 rounded-xl bg-gradient-to-br ${cat.color} flex items-center justify-center text-white shadow-sm`}>
                    <Icon className="w-6 h-6" />
                  </div>
                  <div>
                    <h3 className="font-bold text-slate-900 text-base group-hover:text-emerald-700 transition-colors">
                      {cat.nameUr}
                    </h3>
                    <p className="text-xs font-medium text-slate-500 font-sans">{cat.nameEn}</p>
                  </div>
                  <p className="text-xs text-slate-600 leading-relaxed">{cat.descUr}</p>
                </div>
                <div className="pt-3 border-t border-slate-100 flex items-center justify-between text-xs text-emerald-700 font-semibold">
                  <span>{cat.count}</span>
                  <span className="group-hover:translate-x-1 transition-transform">شروع کریں →</span>
                </div>
              </Link>
            );
          })}
        </div>
      </section>

      {/* Features & Guarantees */}
      <section className="bg-slate-900 text-white py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 grid grid-cols-1 md:grid-cols-3 gap-8">
          <div className="flex items-start gap-4">
            <div className="p-3 bg-emerald-800/50 rounded-xl border border-emerald-700/50">
              <CheckCircle2 className="w-6 h-6 text-emerald-400" />
            </div>
            <div className="space-y-1">
              <h4 className="font-bold text-base">پاکستانی قانون کے مطابق</h4>
              <p className="text-xs text-slate-400 leading-relaxed font-sans">
                Complies with Pakistan Electronic Transactions Ordinance (ETO) 2002 and Contract Act 1872.
              </p>
            </div>
          </div>

          <div className="flex items-start gap-4">
            <div className="p-3 bg-emerald-800/50 rounded-xl border border-emerald-700/50">
              <ShieldCheck className="w-6 h-6 text-emerald-400" />
            </div>
            <div className="space-y-1">
              <h4 className="font-bold text-base">ڈیجیٹل دستخط اور ای او ٹی پی</h4>
              <p className="text-xs text-slate-400 leading-relaxed font-sans">
                Multi-party canvas e-signatures authenticated with SMS/Email OTP and cryptographic timestamps.
              </p>
            </div>
          </div>

          <div className="flex items-start gap-4">
            <div className="p-3 bg-emerald-800/50 rounded-xl border border-emerald-700/50">
              <Sparkles className="w-6 h-6 text-amber-400" />
            </div>
            <div className="space-y-1">
              <h4 className="font-bold text-base">مستند وکیل سے نظر ثانی (24 گھنٹے)</h4>
              <p className="text-xs text-slate-400 leading-relaxed font-sans">
                Optional 1-click review by licensed Bar Council advocates within 24 hours.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
