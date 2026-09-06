import React from "react";
import { cn } from "@/lib/utils";

interface ThemeBadgeProps {
  children: React.ReactNode;
  variant?: "success" | "warning" | "info" | "gold";
  className?: string;
}

export function ThemeBadge({ children, variant = "info", className }: ThemeBadgeProps) {
  const styles = {
    success: "bg-emerald-50 text-emerald-700 border-emerald-200",
    warning: "bg-amber-50 text-amber-700 border-amber-200",
    info: "bg-slate-50 text-slate-700 border-slate-200",
    gold: "bg-amber-100 text-amber-900 border-amber-300 font-bold",
  };

  return (
    <span
      className={cn(
        "inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium border",
        styles[variant],
        className
      )}
    >
      {children}
    </span>
  );
}
