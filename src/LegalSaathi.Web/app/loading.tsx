import React from "react";
import { Loader2 } from "lucide-react";

export default function Loading() {
  return (
    <div className="min-h-[50vh] flex flex-col items-center justify-center gap-3">
      <Loader2 className="w-8 h-8 text-emerald-700 animate-spin" />
      <p className="text-xs text-slate-500 font-medium">لوڈ ہو رہا ہے... براہ کرم انتظار فرمائیں۔</p>
    </div>
  );
}
