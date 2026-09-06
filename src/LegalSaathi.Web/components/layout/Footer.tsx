import React from "react";
import Link from "next/link";
import { Scale, Shield } from "lucide-react";

export function Footer() {
  return (
    <footer className="bg-slate-900 text-slate-400 text-sm border-t border-slate-800">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
          {/* Brand Info */}
          <div className="space-y-3 md:col-span-2">
            <div className="flex items-center gap-2 text-white font-bold text-lg">
              <div className="w-7 h-7 rounded bg-emerald-600 flex items-center justify-center text-white">
                <Scale className="w-4 h-4" />
              </div>
              <span>Legal Saathi · لیگل ساتھی</span>
            </div>
            <p className="text-xs text-slate-400 max-w-md leading-relaxed">
              Pakistan&apos;s premier bilingual AI-powered DIY legal document generation platform. Providing court-compliant legal documentation under the Electronic Transactions Ordinance 2002 and provincial stamp regulations.
            </p>
            <p className="text-xs text-slate-500">
              Engineered by <strong>Nexvora Technologies</strong>.
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h4 className="text-xs font-semibold uppercase tracking-wider text-slate-300 mb-3">Categories</h4>
            <ul className="space-y-2 text-xs">
              <li><Link href="/templates?category=1" className="hover:text-emerald-400 transition-colors">Personal & Family / ذاتی و خاندانی</Link></li>
              <li><Link href="/templates?category=2" className="hover:text-emerald-400 transition-colors">Real Estate & Tenancy / کرایہ داری</Link></li>
              <li><Link href="/templates?category=3" className="hover:text-emerald-400 transition-colors">Business & Freelance / کاروبار</Link></li>
              <li><Link href="/templates?category=4" className="hover:text-emerald-400 transition-colors">Vehicles & Assets / گاڑیاں و اثاثہ جات</Link></li>
            </ul>
          </div>

          {/* Legal Compliance */}
          <div>
            <h4 className="text-xs font-semibold uppercase tracking-wider text-slate-300 mb-3">Legal & Security</h4>
            <ul className="space-y-2 text-xs">
              <li className="flex items-center gap-1.5"><Shield className="w-3.5 h-3.5 text-emerald-500" /> <span>ETO 2002 Compliant</span></li>
              <li><Link href="/disclaimer" className="hover:text-emerald-400 transition-colors">Regulatory Disclaimer</Link></li>
              <li><Link href="/privacy" className="hover:text-emerald-400 transition-colors">Privacy Policy</Link></li>
              <li><Link href="/terms" className="hover:text-emerald-400 transition-colors">Terms of Service</Link></li>
            </ul>
          </div>
        </div>

        <div className="pt-8 border-t border-slate-800 text-center text-xs text-slate-500">
          <p>© {new Date().getFullYear()} Legal Saathi (LegalSaathi.pk) · All rights reserved. Automated self-help software platform, not a substitute for formal legal counsel.</p>
        </div>
      </div>
    </footer>
  );
}
