"use client";

import React, { useState } from "react";
import { X, Scale, Lock, Mail, User as UserIcon, ArrowRight } from "lucide-react";
import { useAuth } from "@/lib/auth-context";

interface AuthModalProps {
  isOpen: boolean;
  onClose: () => void;
  defaultMode?: "login" | "register";
  onSuccess?: () => void;
}

export function AuthModal({ isOpen, onClose, defaultMode = "login", onSuccess }: AuthModalProps) {
  const [mode, setMode] = useState<"login" | "register">(defaultMode);
  const { login, register } = useAuth();

  const [identifier, setIdentifier] = useState("");
  const [password, setPassword] = useState("");
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg("");
    setIsLoading(true);

    if (mode === "login") {
      const res = await login(identifier, password);
      setIsLoading(false);
      if (res.success) {
        onSuccess?.();
        onClose();
      } else {
        setErrorMsg(res.error || "Login failed");
      }
    } else {
      const res = await register({
        fullName,
        email,
        phoneNumber,
        password,
        role: "EndUser",
      });
      setIsLoading(false);
      if (res.success) {
        onSuccess?.();
        onClose();
      } else {
        setErrorMsg(res.error || "Registration failed");
      }
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm">
      <div className="relative w-full max-w-md bg-white rounded-2xl p-6 shadow-2xl border border-slate-100 animate-in fade-in zoom-in-95 duration-200">
        <button
          onClick={onClose}
          className="absolute top-4 right-4 text-slate-400 hover:text-slate-600 p-1.5 rounded-lg hover:bg-slate-100"
        >
          <X className="w-5 h-5" />
        </button>

        <div className="text-center mb-6">
          <div className="w-10 h-10 rounded-xl bg-emerald-700 text-white flex items-center justify-center mx-auto mb-2">
            <Scale className="w-5 h-5" />
          </div>
          <h3 className="text-lg font-bold text-slate-900">
            {mode === "login" ? "Sign In to Legal Saathi" : "Create an Account"}
          </h3>
          <p className="text-xs text-slate-500 font-nastaliq text-emerald-700 font-bold">
            {mode === "login" ? "لیگل ساتھی پر لاگ ان کریں" : "نیا اکاؤنٹ بنائیں"}
          </p>
        </div>

        {errorMsg && (
          <div className="mb-4 bg-rose-50 text-rose-700 border border-rose-200 p-2.5 rounded-lg text-xs">
            {errorMsg}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-3.5">
          {mode === "register" && (
            <>
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Full Name</label>
                <input
                  type="text"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                  placeholder="Muhammad Ali"
                  required
                  className="w-full text-sm py-2 px-3 bg-slate-50 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-600 focus:outline-none"
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Email</label>
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="ali@example.com"
                  required
                  className="w-full text-sm py-2 px-3 bg-slate-50 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-600 focus:outline-none"
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Mobile Number</label>
                <input
                  type="text"
                  value={phoneNumber}
                  onChange={(e) => setPhoneNumber(e.target.value)}
                  placeholder="03001234567"
                  required
                  className="w-full text-sm py-2 px-3 bg-slate-50 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-600 focus:outline-none"
                />
              </div>
            </>
          )}

          {mode === "login" && (
            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1">Email or Mobile Number</label>
              <input
                type="text"
                value={identifier}
                onChange={(e) => setIdentifier(e.target.value)}
                placeholder="03001234567 or user@example.com"
                required
                className="w-full text-sm py-2 px-3 bg-slate-50 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-600 focus:outline-none"
              />
            </div>
          )}

          <div>
            <label className="block text-xs font-semibold text-slate-700 mb-1">Password</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
              required
              className="w-full text-sm py-2 px-3 bg-slate-50 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-600 focus:outline-none"
            />
          </div>

          <button
            type="submit"
            disabled={isLoading}
            className="w-full py-2.5 px-4 rounded-lg bg-emerald-700 hover:bg-emerald-800 text-white font-semibold text-sm transition-all shadow-sm flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50"
          >
            {isLoading ? (
              <span>⏳ Please wait...</span>
            ) : (
              <>
                <span>{mode === "login" ? "Sign In" : "Create Account"}</span>
                <ArrowRight className="w-4 h-4" />
              </>
            )}
          </button>
        </form>

        <div className="mt-4 pt-3 text-center border-t border-slate-100 text-xs text-slate-600">
          {mode === "login" ? (
            <span>
              New to Legal Saathi?{" "}
              <button
                onClick={() => setMode("register")}
                className="text-emerald-700 font-bold hover:underline"
              >
                Register now
              </button>
            </span>
          ) : (
            <span>
              Already have an account?{" "}
              <button
                onClick={() => setMode("login")}
                className="text-emerald-700 font-bold hover:underline"
              >
                Sign In
              </button>
            </span>
          )}
        </div>
      </div>
    </div>
  );
}
