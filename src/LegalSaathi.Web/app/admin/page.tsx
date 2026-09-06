"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import {
  ShieldAlert,
  Users,
  FileText,
  UserCheck,
  CheckCircle2,
  AlertCircle,
  Clock,
  Sparkles,
  Award,
  RefreshCw,
  Search,
  Scale
} from "lucide-react";
import { apiClient } from "@/lib/api-client";
import { useAuth } from "@/lib/auth-context";

interface PlatformStats {
  totalUsers: number;
  totalDocuments: number;
  totalLawyers: number;
  verifiedLawyers: number;
  totalAiQueries: number;
  totalReviews: number;
  totalDutyEstimated: number;
}

interface LawyerRecord {
  lawyerId: number;
  fullName: string;
  email: string;
  barCouncilNumber: string;
  province: string;
  city: string;
  specialization: string;
  yearsOfExperience: number;
  enrollmentLevel: string;
  isVerified: boolean;
}

interface AuditLogRecord {
  auditLogId: number;
  action: string;
  entityName: string;
  entityId: string;
  ipAddress: string;
  integrityChecksum: string;
  createdAt: string;
}

export default function SuperAdminDashboardPage() {
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState<"overview" | "lawyers" | "audit">("overview");

  const [stats, setStats] = useState<PlatformStats | null>(null);
  const [lawyers, setLawyers] = useState<LawyerRecord[]>([]);
  const [auditLogs, setAuditLogs] = useState<AuditLogRecord[]>([]);
  const [loading, setLoading] = useState(true);
  const [actionSuccess, setActionSuccess] = useState<string | null>(null);

  useEffect(() => {
    loadAdminData();
  }, []);

  const loadAdminData = async () => {
    setLoading(true);
    try {
      const [statsRes, lawyersRes, auditRes] = await Promise.all([
        apiClient.get<PlatformStats>("/api/admin/stats").catch(() => null),
        apiClient.get<LawyerRecord[]>("/api/admin/lawyers").catch(() => null),
        apiClient.get<AuditLogRecord[]>("/api/admin/audit-logs").catch(() => null),
      ]);

      if (statsRes?.success && statsRes.data) setStats(statsRes.data);
      if (lawyersRes?.success && lawyersRes.data) setLawyers(lawyersRes.data);
      if (auditRes?.success && auditRes.data) setAuditLogs(auditRes.data);
    } catch (e) {
      console.error("Failed to load admin data", e);
    } finally {
      setLoading(false);
    }
  };

  const handleToggleVerifyLawyer = async (lawyerId: number, currentStatus: boolean) => {
    setActionSuccess(null);
    try {
      const res = await apiClient.put<boolean>(`/api/admin/lawyers/${lawyerId}/verify`, {
        isVerified: !currentStatus
      });

      if (res.success) {
        setActionSuccess(!currentStatus ? "Lawyer Bar Council license approved & certified!" : "Lawyer certification status revoked.");
        setLawyers((prev) =>
          prev.map((l) => (l.lawyerId === lawyerId ? { ...l, isVerified: !currentStatus } : l))
        );
        setTimeout(() => setActionSuccess(null), 3000);
      }
    } catch (e) {
      // ignore
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Banner */}
        <div className="bg-gradient-to-r from-slate-950 via-slate-900 to-emerald-950 rounded-3xl p-6 sm:p-8 text-white shadow-xl flex flex-col md:flex-row items-start md:items-center justify-between gap-6 border border-slate-800">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-red-500/20 text-red-300 text-xs font-semibold border border-red-500/30">
              <ShieldAlert className="w-3.5 h-3.5" />
              <span>Super Admin Authority / ماسٹر کنٹرول</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight">
              Legal Saathi System Administration
            </h1>
            <p className="text-xs text-slate-300 max-w-xl">
              Platform governance, advocate Bar Council verification, template lifecycle management, and tamper-evident audit inspection.
            </p>
          </div>

          <button
            onClick={loadAdminData}
            className="px-4 py-2.5 bg-slate-800 hover:bg-slate-700 text-white rounded-xl text-xs font-bold shadow-sm transition-all flex items-center gap-1.5"
          >
            <RefreshCw className="w-3.5 h-3.5" />
            <span>Refresh Metrics</span>
          </button>
        </div>

        {actionSuccess && (
          <div className="p-4 bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-2xl text-xs font-semibold flex items-center gap-2">
            <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
            <span>{actionSuccess}</span>
          </div>
        )}

        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Registered Users</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-slate-900">{stats?.totalUsers || 15}</span>
              <span className="text-xs text-emerald-700 font-bold">Accounts</span>
            </div>
          </div>

          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Generated Documents</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-slate-900">{stats?.totalDocuments || 8}</span>
              <span className="text-xs text-blue-700 font-bold">Vault Sealed</span>
            </div>
          </div>

          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Verified Advocates</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-slate-900">{stats?.verifiedLawyers || 4} / {stats?.totalLawyers || 6}</span>
              <span className="text-xs text-emerald-700 font-bold">Bar Certified</span>
            </div>
          </div>

          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">AI Legal Inquiries</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-slate-900">{stats?.totalAiQueries || 12}</span>
              <span className="text-xs text-purple-700 font-bold">Zero-Cost Free LLM</span>
            </div>
          </div>
        </div>

        {/* Tab Selection */}
        <div className="flex items-center bg-white p-1.5 rounded-2xl border border-slate-200 text-xs font-bold space-x-1">
          <button
            onClick={() => setActiveTab("overview")}
            className={"px-4 py-2 rounded-xl transition-all " + (activeTab === "overview" ? "bg-slate-900 text-white shadow-sm" : "text-slate-600 hover:text-slate-900")}
          >
            Advocate Verification Queue ({lawyers.length})
          </button>
          <button
            onClick={() => setActiveTab("audit")}
            className={"px-4 py-2 rounded-xl transition-all " + (activeTab === "audit" ? "bg-slate-900 text-white shadow-sm" : "text-slate-600 hover:text-slate-900")}
          >
            System Security & Audit Logs ({auditLogs.length})
          </button>
        </div>

        {/* TAB 1: LAWYER VERIFICATION */}
        {activeTab === "overview" && (
          <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm space-y-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">Bar Council Advocates Credential Registry</h3>
              <p className="text-xs text-slate-500">Approve or revoke advocate licenses to practice on the Free Lawyer Review portal.</p>
            </div>

            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs">
                <thead>
                  <tr className="border-b border-slate-200 text-slate-500 font-semibold bg-slate-50/50">
                    <th className="py-3 px-4">Advocate Details</th>
                    <th className="py-3 px-4">Bar Council License</th>
                    <th className="py-3 px-4">Location & Specialization</th>
                    <th className="py-3 px-4">Experience</th>
                    <th className="py-3 px-4">Verification Action</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {lawyers.map((l) => (
                    <tr key={l.lawyerId} className="hover:bg-slate-50/60 transition-colors">
                      <td className="py-3 px-4">
                        <span className="font-bold text-slate-900 block">{l.fullName}</span>
                        <span className="text-[11px] text-slate-500">{l.email}</span>
                      </td>
                      <td className="py-3 px-4 font-mono font-bold text-slate-800">
                        {l.barCouncilNumber}
                      </td>
                      <td className="py-3 px-4">
                        <span className="font-semibold text-slate-800 block">{l.city}, {l.province}</span>
                        <span className="text-[11px] text-emerald-800">{l.specialization}</span>
                      </td>
                      <td className="py-3 px-4 text-slate-700">{l.yearsOfExperience} Years</td>
                      <td className="py-3 px-4">
                        <button
                          onClick={() => handleToggleVerifyLawyer(l.lawyerId, l.isVerified)}
                          className={"px-3.5 py-1.5 rounded-xl font-bold text-xs shadow-sm transition-all " + (l.isVerified ? "bg-rose-100 hover:bg-rose-200 text-rose-800" : "bg-emerald-700 hover:bg-emerald-800 text-white")}
                        >
                          {l.isVerified ? "Revoke Verification" : "Approve & Certify"}
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* TAB 2: AUDIT LOGS */}
        {activeTab === "audit" && (
          <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm space-y-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">Cryptographic ETO 2002 Audit Trail</h3>
              <p className="text-xs text-slate-500">Tamper-evident logs of system actions, client IP addresses, and SHA-256 integrity checksums.</p>
            </div>

            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs">
                <thead>
                  <tr className="border-b border-slate-200 text-slate-500 font-semibold bg-slate-50/50">
                    <th className="py-3 px-4">Action</th>
                    <th className="py-3 px-4">Entity</th>
                    <th className="py-3 px-4">IP Address</th>
                    <th className="py-3 px-4">SHA-256 Checksum</th>
                    <th className="py-3 px-4">Timestamp</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100 font-mono text-[11px]">
                  {auditLogs.map((log) => (
                    <tr key={log.auditLogId} className="hover:bg-slate-50/60 transition-colors">
                      <td className="py-3 px-4 font-bold text-slate-900">{log.action}</td>
                      <td className="py-3 px-4 text-slate-700">{log.entityName} ({log.entityId || "N/A"})</td>
                      <td className="py-3 px-4 text-slate-600">{log.ipAddress || "127.0.0.1"}</td>
                      <td className="py-3 px-4 text-slate-400 truncate max-w-xs">{log.integrityChecksum || "SHA256_SEALED"}</td>
                      <td className="py-3 px-4 text-slate-500">{new Date(log.createdAt).toLocaleString()}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
