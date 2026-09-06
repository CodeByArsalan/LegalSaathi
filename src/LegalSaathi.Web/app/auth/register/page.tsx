"use client";

import React, { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Scale, User as UserIcon, Mail, Phone, Lock, CreditCard, ShieldCheck, Briefcase, CheckCircle2, ArrowRight } from "lucide-react";
import { useAuth } from "@/lib/auth-context";
import { UserRole } from "@/types/auth";

export default function RegisterPage() {
  const router = useRouter();
  const { register } = useAuth();

  const [role, setRole] = useState<UserRole>("EndUser");
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [cnic, setCnic] = useState("");
  const [password, setPassword] = useState("");
  const [agreeTerms, setAgreeTerms] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");

  // CNIC auto-masking: 35201-1234567-1
  const handleCnicChange = (val: string) => {
    const raw = val.replace(/\D/g, "").slice(0, 13);
    let formatted = raw;
    if (raw.length > 5 && raw.length <= 12) {
      formatted = `${raw.slice(0, 5)}-${raw.slice(5)}`;
    } else if (raw.length > 12) {
      formatted = `${raw.slice(0, 5)}-${raw.slice(5, 12)}-${raw.slice(12, 13)}`;
    }
    setCnic(formatted);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg("");

    if (!agreeTerms) {
      setErrorMsg("Please accept the Terms of Service & Legal Disclaimer.");
      return;
    }

    if (password.length < 8) {
      setErrorMsg("Password must be at least 8 characters long.");
      return;
    }

    setIsLoading(true);
    const res = await register({
      fullName,
      email,
      phoneNumber,
      password,
      cnic: cnic || undefined,
      role,
    });
    setIsLoading(false);

    if (res.success) {
      router.push(`/auth/verify-email?email=${encodeURIComponent(email)}`);
    } else {
      setErrorMsg(res.error || "Registration failed. Please try again.");
    }
  };

  return (
    <div className="min-h-[85vh] flex items-center justify-center py-10 px-4 sm:px-6 lg:px-8 bg-slate-50">
      <div className="max-w-lg w-full space-y-6 bg-white p-8 rounded-2xl shadow-xl border border-slate-200/80">
        {/* Header */}
        <div className="text-center">
          <div className="mx-auto w-12 h-12 rounded-2xl bg-gradient-to-br from-emerald-600 to-emerald-800 flex items-center justify-center text-white shadow-md shadow-emerald-600/20 mb-3">
            <Scale className="w-6 h-6" />
          </div>
          <h2 className="text-2xl font-extrabold text-slate-900 tracking-tight">
            Create Your Account
          </h2>
          <p className="text-sm font-nastaliq text-emerald-700 mt-1 font-bold">
            لیگل ساتھی پر مفت اکاؤنٹ بنائیں
          </p>
        </div>

        {/* Role Selector Tabs */}
        <div className="grid grid-cols-3 gap-2 bg-slate-100 p-1.5 rounded-xl text-xs font-semibold">
          <button
            type="button"
            onClick={() => setRole("EndUser")}
            className={`py-2 px-2 rounded-lg flex flex-col items-center gap-1 transition-all ${
              role === "EndUser"
                ? "bg-white text-emerald-800 shadow-sm font-bold"
                : "text-slate-600 hover:text-slate-900"
            }`}
          >
            <UserIcon className="w-4 h-4" />
            <span>Citizen / شہری</span>
          </button>
          <button
            type="button"
            onClick={() => setRole("CorporateAdmin")}
            className={`py-2 px-2 rounded-lg flex flex-col items-center gap-1 transition-all ${
              role === "CorporateAdmin"
                ? "bg-white text-emerald-800 shadow-sm font-bold"
                : "text-slate-600 hover:text-slate-900"
            }`}
          >
            <Briefcase className="w-4 h-4" />
            <span>Business / کاروبار</span>
          </button>
          <button
            type="button"
            onClick={() => setRole("Lawyer")}
            className={`py-2 px-2 rounded-lg flex flex-col items-center gap-1 transition-all ${
              role === "Lawyer"
                ? "bg-white text-emerald-800 shadow-sm font-bold"
                : "text-slate-600 hover:text-slate-900"
            }`}
          >
            <ShieldCheck className="w-4 h-4" />
            <span>Lawyer / وکیل</span>
          </button>
        </div>

        {/* Error Alert */}
        {errorMsg && (
          <div className="bg-rose-50 border border-rose-200 text-rose-700 px-4 py-3 rounded-xl text-xs flex items-center gap-2">
            <span>⚠️</span>
            <span>{errorMsg}</span>
          </div>
        )}

        <form className="space-y-4" onSubmit={handleSubmit}>
          {/* Full Name */}
          <div>
            <label className="block text-xs font-semibold text-slate-700 mb-1">
              Full Legal Name / پورا نام (شناختی کارڈ کے مطابق)
            </label>
            <div className="relative rounded-xl shadow-sm">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                <UserIcon className="w-4 h-4" />
              </div>
              <input
                type="text"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                placeholder="e.g. Muhammad Usman"
                required
                className="block w-full pl-10 pr-4 py-2 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:ring-2 focus:ring-emerald-600 focus:outline-none"
              />
            </div>
          </div>

          {/* Email & Phone */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1">
                Email Address / ای میل
              </label>
              <div className="relative rounded-xl shadow-sm">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <Mail className="w-4 h-4" />
                </div>
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="name@example.com"
                  required
                  className="block w-full pl-10 pr-3 py-2 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:ring-2 focus:ring-emerald-600 focus:outline-none"
                />
              </div>
            </div>

            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1">
                Pakistani Mobile / موبائل
              </label>
              <div className="relative rounded-xl shadow-sm">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <Phone className="w-4 h-4" />
                </div>
                <input
                  type="text"
                  value={phoneNumber}
                  onChange={(e) => setPhoneNumber(e.target.value)}
                  placeholder="03001234567"
                  required
                  className="block w-full pl-10 pr-3 py-2 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:ring-2 focus:ring-emerald-600 focus:outline-none"
                />
              </div>
            </div>
          </div>

          {/* CNIC (Optional for individual, mandatory for verified docs) */}
          <div>
            <label className="block text-xs font-semibold text-slate-700 mb-1">
              CNIC Number / قومی شناختی کارڈ نمبر
            </label>
            <div className="relative rounded-xl shadow-sm">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                <CreditCard className="w-4 h-4" />
              </div>
              <input
                type="text"
                value={cnic}
                onChange={(e) => handleCnicChange(e.target.value)}
                placeholder="11111-1111111-1"
                className="block w-full pl-10 pr-4 py-2 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:ring-2 focus:ring-emerald-600 focus:outline-none"
              />
            </div>
            <p className="text-[10px] text-slate-500 mt-0.5">13-digit Pakistani CNIC</p>
          </div>

          {/* Password */}
          <div>
            <label className="block text-xs font-semibold text-slate-700 mb-1">
              Password / پاس ورڈ (کم از کم 8 حروف)
            </label>
            <div className="relative rounded-xl shadow-sm">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                <Lock className="w-4 h-4" />
              </div>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
                required
                className="block w-full pl-10 pr-4 py-2 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:ring-2 focus:ring-emerald-600 focus:outline-none"
              />
            </div>
          </div>

          {/* Legal Disclaimer & Terms Checkbox */}
          <div className="flex items-start gap-2 pt-1">
            <input
              type="checkbox"
              id="terms"
              checked={agreeTerms}
              onChange={(e) => setAgreeTerms(e.target.checked)}
              className="mt-1 h-4 w-4 rounded text-emerald-700 focus:ring-emerald-600 border-slate-300"
            />
            <label htmlFor="terms" className="text-xs text-slate-600 leading-relaxed">
              I understand that Legal Saathi is an AI-assisted legal documentation tool. I agree to the{" "}
              <Link href="/terms" className="text-emerald-700 underline font-semibold">Terms of Service</Link>{" "}
              and acknowledge that sensitive legal matters require independent lawyer verification.
            </label>
          </div>

          {/* Submit Button */}
          <button
            type="submit"
            disabled={isLoading}
            className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-xl shadow-sm text-sm font-semibold text-white bg-emerald-700 hover:bg-emerald-800 focus:ring-2 focus:ring-emerald-600 disabled:opacity-50 transition-all cursor-pointer"
          >
            {isLoading ? (
              <span className="inline-block animate-spin text-sm">⏳ Creating account...</span>
            ) : (
              <>
                <span>Complete Registration / رجسٹر کریں</span>
                <ArrowRight className="w-4 h-4" />
              </>
            )}
          </button>
        </form>

        <div className="text-center pt-2 border-t border-slate-100">
          <p className="text-xs text-slate-600">
            Already have an account?{" "}
            <Link
              href="/auth/login"
              className="font-bold text-emerald-700 hover:text-emerald-800"
            >
              Sign In here / لاگ ان کریں
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
