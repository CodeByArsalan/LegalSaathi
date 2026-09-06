"use client";

import React, { useState, useEffect, useRef, Suspense } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { Mail, CheckCircle2, AlertCircle, RotateCcw, ArrowRight, ShieldCheck } from "lucide-react";
import { useAuth } from "@/lib/auth-context";

function VerifyEmailForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const initialEmail = searchParams.get("email") || "";

  const { verifyEmail, resendVerificationEmail } = useAuth();

  const [email, setEmail] = useState(initialEmail);
  const [digits, setDigits] = useState<string[]>(["", "", "", "", "", ""]);
  const [countdown, setCountdown] = useState(60);
  const [isResending, setIsResending] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");
  const [infoMsg, setInfoMsg] = useState("");
  const [isSuccess, setIsSuccess] = useState(false);

  const inputRefs = useRef<(HTMLInputElement | null)[]>([]);

  // 60-second countdown for resend
  useEffect(() => {
    if (countdown <= 0) return;
    const timer = setInterval(() => {
      setCountdown((prev) => prev - 1);
    }, 1000);
    return () => clearInterval(timer);
  }, [countdown]);

  // Handle single digit input
  const handleDigitChange = (index: number, value: string) => {
    const cleaned = value.replace(/\D/g, "");
    if (!cleaned) {
      const updated = [...digits];
      updated[index] = "";
      setDigits(updated);
      return;
    }

    const updated = [...digits];
    updated[index] = cleaned[cleaned.length - 1];
    setDigits(updated);

    if (index < 5) {
      inputRefs.current[index + 1]?.focus();
    }
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Backspace" && !digits[index] && index > 0) {
      inputRefs.current[index - 1]?.focus();
    }
  };

  const handlePaste = (e: React.ClipboardEvent<HTMLInputElement>) => {
    e.preventDefault();
    const pasted = e.clipboardData.getData("text").replace(/\D/g, "").slice(0, 6);
    if (!pasted) return;

    const newDigits = [...digits];
    for (let i = 0; i < 6; i++) {
      newDigits[i] = pasted[i] || "";
    }
    setDigits(newDigits);

    const lastIdx = Math.min(pasted.length - 1, 5);
    inputRefs.current[lastIdx]?.focus();

    if (pasted.length === 6 && email) {
      submitVerification(email, pasted);
    }
  };

  const submitVerification = async (emailToVerify: string, code: string) => {
    setErrorMsg("");
    setInfoMsg("");
    setIsSubmitting(true);

    const res = await verifyEmail(emailToVerify.trim(), code);
    setIsSubmitting(false);

    if (res.success) {
      setIsSuccess(true);
      setTimeout(() => {
        router.push("/templates");
      }, 1500);
    } else {
      setErrorMsg(res.error || "Invalid OTP code. Please check your email and try again.");
    }
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const code = digits.join("");
    if (!email) {
      setErrorMsg("Please provide your email address.");
      return;
    }
    if (code.length < 6) {
      setErrorMsg("Please enter all 6 digits of the verification code.");
      return;
    }

    submitVerification(email, code);
  };

  const handleResend = async () => {
    if (countdown > 0 || !email) return;
    setErrorMsg("");
    setInfoMsg("");
    setIsResending(true);

    const res = await resendVerificationEmail(email.trim());
    setIsResending(false);

    if (res.success) {
      setInfoMsg(res.message || "A fresh 6-digit verification code has been sent to your email.");
      setCountdown(60);
      setDigits(["", "", "", "", "", ""]);
      inputRefs.current[0]?.focus();
    } else {
      setErrorMsg(res.error || "Failed to resend code. Please try again later.");
    }
  };

  return (
    <div className="max-w-md w-full space-y-6 bg-white p-8 rounded-2xl shadow-xl border border-slate-200/80">
      <div className="text-center">
        <div className="mx-auto w-14 h-14 rounded-2xl bg-gradient-to-br from-emerald-600 to-emerald-800 flex items-center justify-center text-white shadow-md shadow-emerald-600/20 mb-4">
          <Mail className="w-7 h-7" />
        </div>
        <h2 className="text-2xl font-extrabold text-slate-900 tracking-tight">
          Verify Your Email
        </h2>
        <p className="text-sm font-nastaliq text-emerald-700 mt-1 font-bold">
          اپنا ای میل ایڈریس تصدیق کریں
        </p>
        <p className="text-xs text-slate-600 mt-2">
          We have sent a 6-digit One-Time Password (OTP) to your email address:
        </p>
        <p className="text-sm font-semibold text-slate-800 mt-1 bg-slate-100 py-1.5 px-3 rounded-lg inline-block break-all">
          {email || "your email"}
        </p>
      </div>

      {isSuccess && (
        <div className="bg-emerald-50 border border-emerald-200 text-emerald-800 px-4 py-3 rounded-xl text-xs flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
          <span className="font-semibold">Email verified successfully! Redirecting to templates...</span>
        </div>
      )}

      {errorMsg && (
        <div className="bg-rose-50 border border-rose-200 text-rose-700 px-4 py-3 rounded-xl text-xs flex items-center gap-2">
          <AlertCircle className="w-4 h-4 text-rose-600 shrink-0" />
          <span>{errorMsg}</span>
        </div>
      )}

      {infoMsg && (
        <div className="bg-sky-50 border border-sky-200 text-sky-800 px-4 py-3 rounded-xl text-xs flex items-center gap-2">
          <ShieldCheck className="w-4 h-4 text-sky-600 shrink-0" />
          <span>{infoMsg}</span>
        </div>
      )}

      <form className="space-y-6" onSubmit={handleSubmit}>
        {!initialEmail && (
          <div>
            <label className="block text-xs font-semibold text-slate-700 mb-1">
              Email Address / ای میل
            </label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="name@example.com"
              required
              className="block w-full px-3 py-2 bg-slate-50 border border-slate-300 rounded-xl text-sm focus:ring-2 focus:ring-emerald-600 focus:outline-none"
            />
          </div>
        )}

        <div>
          <label className="block text-xs font-semibold text-slate-700 mb-2 text-center">
            Enter 6-Digit OTP Code / 6 ہندسوں کا تصدیقی کوڈ درج کریں
          </label>
          <div className="flex items-center justify-center gap-2 sm:gap-3" onPaste={handlePaste}>
            {digits.map((digit, idx) => (
              <input
                key={idx}
                ref={(el) => {
                  inputRefs.current[idx] = el;
                }}
                type="text"
                inputMode="numeric"
                maxLength={1}
                value={digit}
                onChange={(e) => handleDigitChange(idx, e.target.value)}
                onKeyDown={(e) => handleKeyDown(idx, e)}
                disabled={isSubmitting || isSuccess}
                className="w-11 h-13 sm:w-12 sm:h-14 text-center text-xl font-bold rounded-xl border border-slate-300 bg-slate-50 focus:bg-white focus:border-emerald-600 focus:ring-2 focus:ring-emerald-600/20 focus:outline-none transition-all disabled:opacity-50"
                autoFocus={idx === 0}
              />
            ))}
          </div>
          <p className="text-[11px] text-slate-400 text-center mt-2">
            Valid for 5 minutes • Check spam/junk if not received
          </p>
        </div>

        <button
          type="submit"
          disabled={isSubmitting || isSuccess || digits.some((d) => !d)}
          className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-xl shadow-sm text-sm font-semibold text-white bg-emerald-700 hover:bg-emerald-800 focus:ring-2 focus:ring-emerald-600 disabled:opacity-50 transition-all cursor-pointer"
        >
          {isSubmitting ? (
            <span className="inline-block animate-spin text-sm">⏳ Verifying...</span>
          ) : isSuccess ? (
            <span className="flex items-center gap-1.5">
              <CheckCircle2 className="w-4 h-4" /> Verified!
            </span>
          ) : (
            <>
              <span>Confirm Verification / تصدیق مکمل کریں</span>
              <ArrowRight className="w-4 h-4" />
            </>
          )}
        </button>
      </form>

      <div className="text-center pt-3 border-t border-slate-100 flex flex-col items-center gap-2">
        <p className="text-xs text-slate-600">
          Didn&#39;t receive the verification code?
        </p>
        <button
          type="button"
          onClick={handleResend}
          disabled={countdown > 0 || isResending || isSuccess}
          className="inline-flex items-center gap-1.5 text-xs font-semibold text-emerald-700 hover:text-emerald-800 disabled:text-slate-400 disabled:cursor-not-allowed cursor-pointer transition-colors"
        >
          <RotateCcw className={`w-3.5 h-3.5 ${isResending ? "animate-spin" : ""}`} />
          {countdown > 0 ? (
            <span>Resend in {countdown}s (دوبارہ بھیجیں)</span>
          ) : (
            <span>Resend Code / کوڈ دوبارہ بھیجیں</span>
          )}
        </button>
      </div>

      <div className="text-center pt-2">
        <Link
          href="/auth/login"
          className="text-xs text-slate-500 hover:text-slate-700 underline"
        >
          Back to Sign In / لاگ ان پر واپس جائیں
        </Link>
      </div>
    </div>
  );
}

export default function VerifyEmailPage() {
  return (
    <div className="min-h-[80vh] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-slate-50">
      <Suspense fallback={<div className="text-center text-slate-500">Loading verification...</div>}>
        <VerifyEmailForm />
      </Suspense>
    </div>
  );
}
