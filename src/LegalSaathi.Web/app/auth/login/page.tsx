"use client";

import React, { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Scale, Lock, Mail, Phone, Eye, EyeOff, ShieldCheck, ArrowRight, Sparkles } from "lucide-react";
import { useAuth } from "@/lib/auth-context";

export default function LoginPage() {
  const router = useRouter();
  const { login } = useAuth();

  const [identifier, setIdentifier] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [authMethod, setAuthMethod] = useState<"password" | "otp">("password");
  const [otpCode, setOtpCode] = useState("");
  const [otpSent, setOtpSent] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg("");

    if (!identifier.trim()) {
      setErrorMsg("Please enter your email or Pakistani mobile number / برائے مہربانی ای میل یا فون نمبر درج کریں");
      return;
    }

    if (authMethod === "password" && !password) {
      setErrorMsg("Please enter your password / برائے مہربانی اپنا پاس ورڈ درج کریں");
      return;
    }

    setIsLoading(true);
    const res = await login(identifier, password);
    setIsLoading(false);

    if (res.success) {
      router.push("/templates");
    } else {
      setErrorMsg(res.error || "Login failed. Please check your credentials.");
    }
  };

  return (
    <div className="min-h-[80vh] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-slate-50">
      <div className="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-xl border border-slate-200/80">
        {/* Header */}
        <div className="text-center">
          <div className="mx-auto w-12 h-12 rounded-2xl bg-gradient-to-br from-emerald-600 to-emerald-800 flex items-center justify-center text-white shadow-md shadow-emerald-600/20 mb-4">
            <Scale className="w-6 h-6" />
          </div>
          <h2 className="text-2xl font-extrabold text-slate-900 tracking-tight">
            Welcome Back to Legal Saathi
          </h2>
          <p className="text-sm font-nastaliq text-emerald-700 mt-1 font-bold">
            لیگل ساتھی میں خوش آمدید — لاگ ان کریں
          </p>
          <p className="text-xs text-slate-500 mt-1">
            Access your secure legal documents and drafting dashboard
          </p>
        </div>

        {/* Error Alert */}
        {errorMsg && (
          <div className="bg-rose-50 border border-rose-200 text-rose-700 px-4 py-3 rounded-xl text-xs flex items-center gap-2">
            <span className="font-semibold">⚠️</span>
            <span>{errorMsg}</span>
          </div>
        )}

        <form className="mt-6 space-y-5" onSubmit={handleSubmit}>
          {/* Email or Phone */}
          <div>
            <label className="block text-xs font-semibold text-slate-700 mb-1">
              Email or Mobile Number / ای میل یا موبائل نمبر
            </label>
            <div className="relative rounded-xl shadow-sm">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                <Mail className="w-4 h-4" />
              </div>
              <input
                type="text"
                value={identifier}
                onChange={(e) => setIdentifier(e.target.value)}
                placeholder="03001234567 or user@example.com"
                required
                className="block w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:border-transparent transition-all"
              />
            </div>
          </div>

          {/* Password Input */}
          <div>
            <div className="flex items-center justify-between mb-1">
              <label className="block text-xs font-semibold text-slate-700">
                Password / پاس ورڈ
              </label>
              <Link
                href="/auth/forgot-password"
                className="text-xs text-emerald-700 hover:text-emerald-800 font-medium"
              >
                Forgot password?
              </Link>
            </div>
            <div className="relative rounded-xl shadow-sm">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                <Lock className="w-4 h-4" />
              </div>
              <input
                type={showPassword ? "text" : "password"}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
                required
                className="block w-full pl-10 pr-10 py-2.5 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:border-transparent transition-all"
              />
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                className="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600"
              >
                {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            </div>
          </div>

          {/* Submit Button */}
          <div>
            <button
              type="submit"
              disabled={isLoading}
              className="w-full flex items-center justify-center gap-2 py-3 px-4 border border-transparent rounded-xl shadow-sm text-sm font-semibold text-white bg-emerald-700 hover:bg-emerald-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-600 disabled:opacity-50 transition-all cursor-pointer"
            >
              {isLoading ? (
                <span className="inline-block animate-spin text-sm">⏳ Processing...</span>
              ) : (
                <>
                  <span>Sign In / لاگ ان</span>
                  <ArrowRight className="w-4 h-4" />
                </>
              )}
            </button>
          </div>
        </form>

        {/* Footer info */}
        <div className="text-center pt-2 border-t border-slate-100">
          <p className="text-xs text-slate-600">
            Don&apos;t have an account?{" "}
            <Link
              href="/auth/register"
              className="font-bold text-emerald-700 hover:text-emerald-800"
            >
              Register for free / نیا اکاؤنٹ بنائیں
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
