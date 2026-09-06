"use client";

import React, { useState, useRef, useEffect } from "react";
import {
  X,
  PenTool,
  ShieldCheck,
  CheckCircle2,
  AlertTriangle,
  RotateCcw,
  Send,
  Lock,
  FileCheck
} from "lucide-react";
import { apiClient } from "@/lib/api-client";
import { useAuth } from "@/lib/auth-context";

interface SignatureModalProps {
  isOpen: boolean;
  onClose: () => void;
  documentId: number;
  documentTitle: string;
  onSignedSuccess: () => void;
}

export function SignatureModal({
  isOpen,
  onClose,
  documentId,
  documentTitle,
  onSignedSuccess
}: SignatureModalProps) {
  const { user } = useAuth();

  const canvasRef = useRef<HTMLCanvasElement | null>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [hasSignature, setHasSignature] = useState(false);
  const [inkColor, setInkColor] = useState<"#0f172a" | "#1d4ed8">("#0f172a");

  const [step, setStep] = useState<"draw" | "otp">("draw");
  const [signerName, setSignerName] = useState(user?.fullName || "");
  const [signerCnic, setSignerCnic] = useState(user?.cnic || "");
  const [signerRole, setSignerRole] = useState("Deponent");
  const [phoneOrEmail, setPhoneOrEmail] = useState(user?.email || "");
  const [otpCode, setOtpCode] = useState("");
  const [maskedDest, setMaskedDest] = useState("");

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSendingOtp, setIsSendingOtp] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");
  const [consentChecked, setConsentChecked] = useState(false);

  // Initialize Canvas
  useEffect(() => {
    if (isOpen && step === "draw") {
      setTimeout(() => {
        const canvas = canvasRef.current;
        if (canvas) {
          const ctx = canvas.getContext("2d");
          if (ctx) {
            ctx.strokeStyle = inkColor;
            ctx.lineWidth = 2.5;
            ctx.lineCap = "round";
            ctx.lineJoin = "round";
          }
        }
      }, 100);
    }
  }, [isOpen, step, inkColor]);

  if (!isOpen) return null;

  // Drawing Handlers
  const startDrawing = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    setIsDrawing(true);
    const rect = canvas.getBoundingClientRect();
    const x = "touches" in e ? e.touches[0].clientX - rect.left : e.clientX - rect.left;
    const y = "touches" in e ? e.touches[0].clientY - rect.top : e.clientY - rect.top;

    ctx.beginPath();
    ctx.moveTo(x, y);
  };

  const draw = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
    if (!isDrawing) return;
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    const rect = canvas.getBoundingClientRect();
    const x = "touches" in e ? e.touches[0].clientX - rect.left : e.clientX - rect.left;
    const y = "touches" in e ? e.touches[0].clientY - rect.top : e.clientY - rect.top;

    ctx.lineTo(x, y);
    ctx.stroke();
    setHasSignature(true);
  };

  const stopDrawing = () => {
    setIsDrawing(false);
  };

  const clearCanvas = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext("2d");
    if (!ctx) return;
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    setHasSignature(false);
  };

  const formatCnic = (val: string) => {
    const digits = val.replace(/\D/g, "").slice(0, 13);
    if (digits.length <= 5) return digits;
    if (digits.length <= 12) return digits.slice(0, 5) + "-" + digits.slice(5);
    return digits.slice(0, 5) + "-" + digits.slice(5, 12) + "-" + digits.slice(12, 13);
  };

  const handleProceedToOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg("");

    if (!signerName.trim()) {
      setErrorMsg("Please provide your legal full name.");
      return;
    }
    if (signerCnic.length !== 15) {
      setErrorMsg("Valid 13-digit Pakistani CNIC required (e.g. 35201-1234567-1).");
      return;
    }
    if (!hasSignature) {
      setErrorMsg("Please draw your electronic signature on the canvas.");
      return;
    }
    if (!consentChecked) {
      setErrorMsg("You must accept the Electronic Transactions Ordinance 2002 legal declaration.");
      return;
    }

    setIsSendingOtp(true);
    try {
      const res = await apiClient.post<{ success: boolean; message: string; destinationMasked: string }>(
        "/api/documents/" + documentId + "/signatures/request-otp",
        {
          userDocumentId: documentId,
          signerName,
          signerCnic,
          destinationPhoneOrEmail: phoneOrEmail || user?.email || user?.phoneNumber || "03001234567"
        }
      );

      if (res.success && res.data) {
        setMaskedDest(res.data.destinationMasked);
        setStep("otp");
      } else {
        setErrorMsg(res.message || "Failed to generate authorization OTP.");
      }
    } catch (err: any) {
      setErrorMsg(err.message || "Failed to send authorization code.");
    } finally {
      setIsSendingOtp(false);
    }
  };

  const handleSubmitSignature = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg("");

    if (otpCode.length < 4) {
      setErrorMsg("Please enter the 6-digit OTP code.");
      return;
    }

    const canvas = canvasRef.current;
    const base64Image = canvas ? canvas.toDataURL("image/png") : "";

    setIsSubmitting(true);
    try {
      const res = await apiClient.post(
        "/api/documents/" + documentId + "/signatures",
        {
          userDocumentId: documentId,
          signerName,
          signerCnic,
          signerRole,
          signerPhone: phoneOrEmail.includes("@") ? null : phoneOrEmail,
          signerEmail: phoneOrEmail.includes("@") ? phoneOrEmail : null,
          signatureBase64Image: base64Image,
          otpCode
        }
      );

      if (res.success) {
        onSignedSuccess();
        onClose();
      } else {
        setErrorMsg(res.message || "Verification failed. Check your OTP code.");
      }
    } catch (err: any) {
      setErrorMsg(err.message || "Failed to complete signature.");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/60 backdrop-blur-sm p-4 overflow-y-auto">
      <div className="bg-white rounded-3xl max-w-lg w-full p-6 shadow-2xl border border-slate-100 relative animate-in fade-in zoom-in-95 duration-200">
        {/* Close Button */}
        <button
          onClick={onClose}
          className="absolute top-5 right-5 text-slate-400 hover:text-slate-700 p-1.5 rounded-full hover:bg-slate-100 transition-colors"
        >
          <X className="w-5 h-5" />
        </button>

        {/* Modal Header */}
        <div className="flex items-center gap-3 mb-5">
          <div className="w-10 h-10 rounded-2xl bg-emerald-50 border border-emerald-200 flex items-center justify-center text-emerald-700">
            <PenTool className="w-5 h-5" />
          </div>
          <div>
            <h2 className="text-base font-bold text-slate-900">Digital E-Signature</h2>
            <p className="text-xs text-slate-500 truncate max-w-xs">{documentTitle}</p>
          </div>
        </div>

        {errorMsg && (
          <div className="mb-4 p-3 bg-red-50 border border-red-200 text-red-700 rounded-xl text-xs flex items-center gap-2">
            <AlertTriangle className="w-4 h-4 shrink-0" />
            <span>{errorMsg}</span>
          </div>
        )}

        {step === "draw" ? (
          <form onSubmit={handleProceedToOtp} className="space-y-4">
            {/* Signer Identity */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">
                  Full Name (as per CNIC)
                </label>
                <input
                  type="text"
                  required
                  value={signerName}
                  onChange={(e) => setSignerName(e.target.value)}
                  placeholder="e.g. Muhammad Ali"
                  className="w-full text-xs px-3 py-2 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">
                  CNIC Number
                </label>
                <input
                  type="text"
                  required
                  maxLength={15}
                  value={signerCnic}
                  onChange={(e) => setSignerCnic(formatCnic(e.target.value))}
                  placeholder="11111-1111111-1"
                  className="w-full text-xs px-3 py-2 border border-slate-200 rounded-xl font-mono focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                />
              </div>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">
                  Signer Capacity / Role
                </label>
                <select
                  value={signerRole}
                  onChange={(e) => setSignerRole(e.target.value)}
                  className="w-full text-xs px-3 py-2 border border-slate-200 rounded-xl bg-white focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                >
                  <option value="Deponent">Deponent (بیان دہندہ)</option>
                  <option value="FirstParty">First Party (فریق اول)</option>
                  <option value="SecondParty">Second Party (فریق دوم)</option>
                  <option value="Landlord">Landlord (مالک مکان)</option>
                  <option value="Tenant">Tenant (کرایہ دار)</option>
                  <option value="Buyer">Buyer (خریدار)</option>
                  <option value="Seller">Seller (فروخت کنندہ)</option>
                  <option value="Witness">Witness (گواہ)</option>
                </select>
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">
                  Mobile or Email for OTP
                </label>
                <input
                  type="text"
                  required
                  value={phoneOrEmail}
                  onChange={(e) => setPhoneOrEmail(e.target.value)}
                  placeholder="03XXXXXXXXX or user@email.com"
                  className="w-full text-xs px-3 py-2 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                />
              </div>
            </div>

            {/* Signature Canvas */}
            <div>
              <div className="flex items-center justify-between mb-1.5">
                <label className="text-xs font-semibold text-slate-700 flex items-center gap-1.5">
                  <PenTool className="w-3.5 h-3.5 text-emerald-600" />
                  Draw Signature Here
                </label>
                <div className="flex items-center gap-2">
                  <div className="flex items-center gap-1 bg-slate-100 p-0.5 rounded-lg">
                    <button
                      type="button"
                      onClick={() => setInkColor("#0f172a")}
                      className={"w-4 h-4 rounded-full bg-slate-900 border " + (inkColor === "#0f172a" ? "ring-2 ring-emerald-500" : "")}
                    />
                    <button
                      type="button"
                      onClick={() => setInkColor("#1d4ed8")}
                      className={"w-4 h-4 rounded-full bg-blue-700 border " + (inkColor === "#1d4ed8" ? "ring-2 ring-emerald-500" : "")}
                    />
                  </div>
                  <button
                    type="button"
                    onClick={clearCanvas}
                    className="text-[11px] text-slate-500 hover:text-red-600 flex items-center gap-1 font-medium transition-colors"
                  >
                    <RotateCcw className="w-3 h-3" /> Clear
                  </button>
                </div>
              </div>

              <div className="border-2 border-dashed border-slate-300 rounded-2xl bg-slate-50 relative overflow-hidden touch-none">
                <canvas
                  ref={canvasRef}
                  width={460}
                  height={150}
                  onMouseDown={startDrawing}
                  onMouseMove={draw}
                  onMouseUp={stopDrawing}
                  onMouseLeave={stopDrawing}
                  onTouchStart={startDrawing}
                  onTouchMove={draw}
                  onTouchEnd={stopDrawing}
                  className="w-full h-[150px] cursor-crosshair"
                />
                {!hasSignature && (
                  <div className="absolute inset-0 flex items-center justify-center pointer-events-none text-slate-400 text-xs font-medium">
                    Use mouse, finger or stylus to sign
                  </div>
                )}
              </div>
            </div>

            {/* Legal Consent Checkbox */}
            <div className="p-3 bg-slate-50 rounded-2xl border border-slate-200 flex items-start gap-2.5">
              <input
                type="checkbox"
                id="eto-consent"
                checked={consentChecked}
                onChange={(e) => setConsentChecked(e.target.checked)}
                className="mt-0.5 rounded text-emerald-600 focus:ring-emerald-500"
              />
              <label htmlFor="eto-consent" className="text-[11px] text-slate-600 leading-relaxed cursor-pointer">
                I acknowledge that this electronic signature carries full evidentiary weight and legal binding effect under the <b>Pakistan Electronic Transactions Ordinance (ETO) 2002</b>.
              </label>
            </div>

            {/* Action Buttons */}
            <div className="flex gap-2.5 pt-2">
              <button
                type="button"
                onClick={onClose}
                className="flex-1 py-2.5 text-xs font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors"
              >
                Cancel
              </button>
              <button
                type="submit"
                disabled={isSendingOtp || !hasSignature || !consentChecked}
                className="flex-1 py-2.5 text-xs font-semibold text-white bg-emerald-700 hover:bg-emerald-800 disabled:opacity-50 rounded-xl shadow-sm transition-all flex items-center justify-center gap-1.5"
              >
                {isSendingOtp ? "Generating OTP..." : "Proceed to OTP Verification"}
              </button>
            </div>
          </form>
        ) : (
          <form onSubmit={handleSubmitSignature} className="space-y-4">
            <div className="p-4 bg-emerald-50 border border-emerald-200 rounded-2xl text-center space-y-1">
              <ShieldCheck className="w-7 h-7 text-emerald-600 mx-auto" />
              <h3 className="text-xs font-bold text-emerald-950">Enter Verification Code</h3>
              <p className="text-[11px] text-emerald-700">
                A 6-digit one-time code has been sent to <b>{maskedDest}</b>
              </p>
            </div>

            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1 text-center">
                6-Digit Security OTP
              </label>
              <input
                type="text"
                required
                maxLength={6}
                value={otpCode}
                onChange={(e) => setOtpCode(e.target.value.replace(/\D/g, ""))}
                placeholder="123456"
                className="w-48 mx-auto block text-center tracking-widest text-lg font-bold font-mono px-3 py-2.5 border-2 border-emerald-600 rounded-xl focus:outline-none"
              />
            </div>

            <div className="text-center">
              <button
                type="button"
                onClick={handleProceedToOtp}
                disabled={isSendingOtp}
                className="text-[11px] text-emerald-700 hover:underline font-semibold"
              >
                {isSendingOtp ? "Resending..." : "Resend Code"}
              </button>
            </div>

            <div className="flex gap-2.5 pt-2">
              <button
                type="button"
                onClick={() => setStep("draw")}
                className="flex-1 py-2.5 text-xs font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors"
              >
                Back to Canvas
              </button>
              <button
                type="submit"
                disabled={isSubmitting || otpCode.length < 4}
                className="flex-1 py-2.5 text-xs font-semibold text-white bg-emerald-700 hover:bg-emerald-800 disabled:opacity-50 rounded-xl shadow-sm transition-all flex items-center justify-center gap-1.5"
              >
                {isSubmitting ? "Verifying & Signing..." : "Confirm & Sign Document"}
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  );
}
