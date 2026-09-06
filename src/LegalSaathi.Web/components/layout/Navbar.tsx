"use client";

import React, { useState } from "react";
import Link from "next/link";
import { Scale, FileText, ShieldCheck, Sparkles, User as UserIcon, LogOut, FileCode } from "lucide-react";
import { LanguageToggle } from "../common/LanguageToggle";
import { useAuth } from "@/lib/auth-context";

export function Navbar() {
  const { user, isAuthenticated, logout } = useAuth();
  const [dropdownOpen, setDropdownOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 bg-white/95 backdrop-blur-sm border-b border-slate-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
        {/* Brand Logo */}
        <Link href="/" className="flex items-center gap-2.5">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-emerald-600 to-emerald-800 flex items-center justify-center text-white shadow-sm shadow-emerald-500/20">
            <Scale className="w-5 h-5" />
          </div>
          <div>
            <span className="font-bold text-lg text-slate-900 tracking-tight">Legal Saathi</span>
            <span className="block text-[10px] font-medium text-emerald-700 tracking-wide">لیگل ساتھی پاکستان</span>
          </div>
        </Link>

        {/* Navigation Links */}
        <nav className="hidden md:flex items-center gap-6 text-sm font-medium text-slate-600">
          <Link href="/templates" className="hover:text-emerald-700 transition-colors flex items-center gap-1.5">
            <FileText className="w-4 h-4" />
            <span>Templates / دستاویزات</span>
          </Link>
          <Link href="/ai-assistant" className="hover:text-emerald-700 transition-colors flex items-center gap-1.5">
            <Sparkles className="w-4 h-4 text-amber-500" />
            <span>AI Legal Saathi</span>
          </Link>
          <Link href="/lawyer" className="hover:text-emerald-700 transition-colors flex items-center gap-1.5">
            <ShieldCheck className="w-4 h-4 text-emerald-600" />
            <span>Lawyer Review</span>
          </Link>
        </nav>

        {/* Actions */}
        <div className="flex items-center gap-3">
          <LanguageToggle />

          {isAuthenticated && user ? (
            <div className="relative">
              <button
                onClick={() => setDropdownOpen(!dropdownOpen)}
                className="flex items-center gap-2 py-1 px-2.5 rounded-xl border border-slate-200 bg-slate-50 hover:bg-slate-100 transition-all text-sm font-medium text-slate-800 cursor-pointer"
              >
                <div className="w-7 h-7 rounded-lg bg-emerald-700 text-white flex items-center justify-center font-bold text-xs">
                  {user.fullName.charAt(0).toUpperCase()}
                </div>
                <span className="hidden sm:inline text-xs font-semibold">{user.fullName.split(" ")[0]}</span>
                <span className="text-[10px] px-1.5 py-0.5 rounded bg-emerald-100 text-emerald-800 font-bold">
                  {user.role}
                </span>
              </button>

              {dropdownOpen && (
                <div className="absolute right-0 mt-2 w-48 bg-white rounded-xl shadow-lg border border-slate-200 py-1.5 z-50 animate-in fade-in zoom-in-95">
                  <div className="px-3 py-2 border-b border-slate-100">
                    <p className="text-xs font-bold text-slate-900 truncate">{user.fullName}</p>
                    <p className="text-[11px] text-slate-500 truncate">{user.email || user.phoneNumber}</p>
                  </div>
                  <Link
                    href="/dashboard"
                    onClick={() => setDropdownOpen(false)}
                    className="flex items-center gap-2 px-3 py-2 text-xs text-slate-700 hover:bg-slate-50"
                  >
                    <FileCode className="w-3.5 h-3.5" />
                    <span>My Documents</span>
                  </Link>
                  <button
                    onClick={async () => {
                      setDropdownOpen(false);
                      await logout();
                    }}
                    className="w-full flex items-center gap-2 px-3 py-2 text-xs text-rose-600 hover:bg-rose-50 text-left cursor-pointer"
                  >
                    <LogOut className="w-3.5 h-3.5" />
                    <span>Sign Out / لاگ آؤٹ</span>
                  </button>
                </div>
              )}
            </div>
          ) : (
            <>
              <Link
                href="/auth/login"
                className="text-sm font-medium text-slate-700 hover:text-emerald-700 px-3 py-1.5 transition-colors"
              >
                Login
              </Link>
              <Link
                href="/auth/register"
                className="text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-800 px-4 py-2 rounded-lg shadow-sm transition-colors"
              >
                Get Started Free
              </Link>
            </>
          )}
        </div>
      </div>
    </header>
  );
}

