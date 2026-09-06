"use client";

import React, { useState } from "react";
import Link from "next/link";
import {
  Building2,
  Users,
  FileText,
  ShieldCheck,
  Plus,
  ArrowRight,
  Download,
  CheckCircle2,
  Lock,
  Mail,
  Briefcase,
  Share2
} from "lucide-react";
import { useAuth } from "@/lib/auth-context";

interface TeamMember {
  id: number;
  name: string;
  email: string;
  department: string;
  role: string;
  status: "Active" | "Invited";
}

export default function CorporateAdminPortalPage() {
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState<"overview" | "team" | "contracts" | "compliance">("overview");

  const [teamMembers, setTeamMembers] = useState<TeamMember[]>([
    { id: 1, name: "Arsalan Corporate Admin", email: "corporate@legalsaathi.pk", department: "Executive / Legal", role: "Corporate Admin", status: "Active" },
    { id: 2, name: "Haris Procurement Lead", email: "procurement@legalsaathi.pk", department: "Procurement & Vendor Ops", role: "Manager", status: "Active" },
    { id: 3, name: "Sara HR Operations", email: "hr@legalsaathi.pk", department: "Human Resources", role: "Manager", status: "Active" },
    { id: 4, name: "Zaid Compliance Officer", email: "compliance@legalsaathi.pk", department: "Risk & Audit", role: "Auditor", status: "Invited" },
  ]);

  const [inviteModalOpen, setInviteModalOpen] = useState(false);
  const [inviteName, setInviteName] = useState("");
  const [inviteEmail, setInviteEmail] = useState("");
  const [inviteDept, setInviteDept] = useState("Human Resources");

  const handleInviteSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!inviteName || !inviteEmail) return;

    setTeamMembers((prev) => [
      ...prev,
      {
        id: prev.length + 1,
        name: inviteName,
        email: inviteEmail,
        department: inviteDept,
        role: "Member",
        status: "Invited"
      }
    ]);

    setInviteName("");
    setInviteEmail("");
    setInviteModalOpen(false);
  };

  return (
    <div className="min-h-screen bg-slate-50 py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Banner */}
        <div className="bg-gradient-to-r from-slate-900 via-emerald-950 to-slate-900 rounded-3xl p-6 sm:p-8 text-white shadow-xl flex flex-col md:flex-row items-start md:items-center justify-between gap-6 border border-slate-800">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/10 text-emerald-300 text-xs font-semibold">
              <Building2 className="w-3.5 h-3.5" />
              <span>Corporate Admin Workspace / کارپوریٹ پورٹل</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight">
              Enterprise Legal Management
            </h1>
            <p className="text-xs text-slate-300 max-w-xl">
              Centralized organizational hub for corporate contracts, bilingual NDAs, employee agreements, and team authorization under Pakistan Contract Act 1872.
            </p>
          </div>

          <div className="flex flex-wrap items-center gap-2.5">
            <button
              onClick={() => setInviteModalOpen(true)}
              className="px-4 py-2.5 bg-emerald-700 hover:bg-emerald-800 text-white rounded-xl text-xs font-bold shadow-sm transition-all flex items-center gap-1.5"
            >
              <Plus className="w-4 h-4" />
              <span>Invite Team Member</span>
            </button>
            <Link
              href="/templates?category=3"
              className="px-4 py-2.5 bg-white text-slate-900 hover:bg-slate-100 rounded-xl text-xs font-bold shadow-sm transition-all flex items-center gap-1.5"
            >
              <FileText className="w-4 h-4 text-emerald-700" />
              <span>Draft Corporate Agreement</span>
            </Link>
          </div>
        </div>

        {/* Metric Cards */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Active Team Seats</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-slate-900">{teamMembers.length} / 10</span>
              <span className="text-xs text-emerald-700 font-bold">Enterprise Tier</span>
            </div>
          </div>

          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Executed NDAs & MOUs</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-slate-900">14</span>
              <span className="text-xs text-blue-700 font-bold">100% Signed</span>
            </div>
          </div>

          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Employment Contracts</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-slate-900">8</span>
              <span className="text-xs text-emerald-700 font-bold">Labor Compliant</span>
            </div>
          </div>

          <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm space-y-1">
            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Integrity Audit Seal</span>
            <div className="flex items-baseline justify-between">
              <span className="text-2xl font-black text-emerald-800">Verified</span>
              <span className="text-xs text-emerald-700 font-bold">ETO 2002</span>
            </div>
          </div>
        </div>

        {/* Tab Navigation */}
        <div className="flex items-center bg-white p-1.5 rounded-2xl border border-slate-200 text-xs font-bold space-x-1">
          <button
            onClick={() => setActiveTab("overview")}
            className={"px-4 py-2 rounded-xl transition-all " + (activeTab === "overview" ? "bg-slate-900 text-white shadow-sm" : "text-slate-600 hover:text-slate-900")}
          >
            Organization Overview
          </button>
          <button
            onClick={() => setActiveTab("team")}
            className={"px-4 py-2 rounded-xl transition-all " + (activeTab === "team" ? "bg-slate-900 text-white shadow-sm" : "text-slate-600 hover:text-slate-900")}
          >
            Team Seats ({teamMembers.length})
          </button>
          <button
            onClick={() => setActiveTab("contracts")}
            className={"px-4 py-2 rounded-xl transition-all " + (activeTab === "contracts" ? "bg-slate-900 text-white shadow-sm" : "text-slate-600 hover:text-slate-900")}
          >
            Corporate Template Suite
          </button>
        </div>

        {/* TAB 1: OVERVIEW */}
        {activeTab === "overview" && (
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div className="lg:col-span-2 bg-white rounded-3xl p-6 border border-slate-200 shadow-sm space-y-4">
              <h3 className="text-sm font-bold text-slate-900 flex items-center gap-2">
                <Briefcase className="w-4 h-4 text-emerald-700" />
                Quick Corporate Drafting Suite
              </h3>
              <p className="text-xs text-slate-500">
                Launch standardized Pakistani bilingual agreements pre-configured for your enterprise.
              </p>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2">
                <Link
                  href="/templates/non-disclosure-agreement-nda"
                  className="p-4 bg-slate-50 hover:bg-emerald-50/50 rounded-2xl border border-slate-200 transition-all space-y-1.5 block group"
                >
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-slate-900 group-hover:text-emerald-800">Mutual Non-Disclosure (NDA)</h4>
                    <ArrowRight className="w-3.5 h-3.5 text-slate-400 group-hover:text-emerald-700" />
                  </div>
                  <p className="text-[11px] text-slate-500">Protect trade secrets, client IP, and vendor negotiations under Contract Act 1872.</p>
                </Link>

                <Link
                  href="/templates/employment-contract"
                  className="p-4 bg-slate-50 hover:bg-emerald-50/50 rounded-2xl border border-slate-200 transition-all space-y-1.5 block group"
                >
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-slate-900 group-hover:text-emerald-800">Standard Employment Contract</h4>
                    <ArrowRight className="w-3.5 h-3.5 text-slate-400 group-hover:text-emerald-700" />
                  </div>
                  <p className="text-[11px] text-slate-500">Industrial & Commercial Employment Ordinance 1968 statutory compliance.</p>
                </Link>

                <Link
                  href="/templates/memorandum-of-understanding-mou"
                  className="p-4 bg-slate-50 hover:bg-emerald-50/50 rounded-2xl border border-slate-200 transition-all space-y-1.5 block group"
                >
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-slate-900 group-hover:text-emerald-800">Memorandum of Understanding</h4>
                    <ArrowRight className="w-3.5 h-3.5 text-slate-400 group-hover:text-emerald-700" />
                  </div>
                  <p className="text-[11px] text-slate-500">Strategic B2B partnerships and institutional collaboration frameworks.</p>
                </Link>

                <Link
                  href="/templates/partnership-deed-sharakat-nama"
                  className="p-4 bg-slate-50 hover:bg-emerald-50/50 rounded-2xl border border-slate-200 transition-all space-y-1.5 block group"
                >
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-slate-900 group-hover:text-emerald-800">Partnership Deed (Sharakat)</h4>
                    <ArrowRight className="w-3.5 h-3.5 text-slate-400 group-hover:text-emerald-700" />
                  </div>
                  <p className="text-[11px] text-slate-500">Partnership Act 1932 capital allocation and profit distribution deed.</p>
                </Link>
              </div>
            </div>

            {/* Corporate Vault Info */}
            <div className="bg-gradient-to-br from-slate-900 to-slate-800 text-white rounded-3xl p-6 shadow-xl border border-slate-700 space-y-4">
              <div className="flex items-center gap-2.5">
                <div className="w-8 h-8 rounded-xl bg-emerald-500/20 flex items-center justify-center text-emerald-400">
                  <ShieldCheck className="w-4 h-4" />
                </div>
                <div>
                  <h4 className="text-xs font-bold">Enterprise Encryption Vault</h4>
                  <p className="text-[10px] text-slate-400">Organization ID: LS-CORP-9801</p>
                </div>
              </div>
              <p className="text-xs text-slate-300 leading-relaxed">
                All organizational documents are signed with cryptographic OTP attestation under Electronic Transactions Ordinance 2002.
              </p>
              <div className="p-3 bg-white/5 rounded-2xl border border-white/10 text-[11px] space-y-1.5">
                <div className="flex justify-between text-slate-300">
                  <span>Organization Tier:</span>
                  <span className="font-bold text-emerald-400">Corporate Pro</span>
                </div>
                <div className="flex justify-between text-slate-300">
                  <span>Advocate Review Allocation:</span>
                  <span className="font-bold text-white">Unlimited Free Reviews</span>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* TAB 2: TEAM SEATS */}
        {activeTab === "team" && (
          <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-sm font-bold text-slate-900">Organization Authorized Members</h3>
                <p className="text-xs text-slate-500">Manage user access for drafting and signing corporate legal documents.</p>
              </div>
              <button
                onClick={() => setInviteModalOpen(true)}
                className="px-3.5 py-2 bg-emerald-700 hover:bg-emerald-800 text-white rounded-xl text-xs font-bold shadow-sm transition-all flex items-center gap-1.5"
              >
                <Plus className="w-3.5 h-3.5" /> Invite Member
              </button>
            </div>

            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs">
                <thead>
                  <tr className="border-b border-slate-200 text-slate-500 font-semibold bg-slate-50/50">
                    <th className="py-3 px-4">Member Name</th>
                    <th className="py-3 px-4">Department</th>
                    <th className="py-3 px-4">Access Role</th>
                    <th className="py-3 px-4">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {teamMembers.map((m) => (
                    <tr key={m.id} className="hover:bg-slate-50/60 transition-colors">
                      <td className="py-3 px-4">
                        <span className="font-bold text-slate-900 block">{m.name}</span>
                        <span className="text-[11px] text-slate-500">{m.email}</span>
                      </td>
                      <td className="py-3 px-4 text-slate-700">{m.department}</td>
                      <td className="py-3 px-4 font-semibold text-slate-800">{m.role}</td>
                      <td className="py-3 px-4">
                        <span className={"px-2.5 py-0.5 rounded-full text-[10px] font-bold " + (m.status === "Active" ? "bg-emerald-100 text-emerald-800" : "bg-amber-100 text-amber-800")}>
                          {m.status}
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* TAB 3: CONTRACTS */}
        {activeTab === "contracts" && (
          <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm space-y-4">
            <h3 className="text-sm font-bold text-slate-900">Corporate Legal Templates</h3>
            <p className="text-xs text-slate-500">Select any template to launch the automated questionnaire.</p>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 pt-2">
              <div className="p-4 rounded-2xl border border-slate-200 bg-slate-50 space-y-2">
                <h4 className="text-xs font-bold text-slate-900">Non-Disclosure Agreement (NDA)</h4>
                <p className="text-[11px] text-slate-600">Standard bilateral confidentiality clauses compliant with Pakistani common law.</p>
                <Link href="/templates/non-disclosure-agreement-nda" className="inline-block text-xs font-bold text-emerald-700 hover:underline">
                  Launch Generator &rarr;
                </Link>
              </div>

              <div className="p-4 rounded-2xl border border-slate-200 bg-slate-50 space-y-2">
                <h4 className="text-xs font-bold text-slate-900">Employment Agreement</h4>
                <p className="text-[11px] text-slate-600">Standard labor contract including probation, leave entitlement, and non-solicitation.</p>
                <Link href="/templates/employment-contract" className="inline-block text-xs font-bold text-emerald-700 hover:underline">
                  Launch Generator &rarr;
                </Link>
              </div>
            </div>
          </div>
        )}

        {/* Invite Modal */}
        {inviteModalOpen && (
          <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-xs z-50 flex items-center justify-center p-4">
            <div className="bg-white rounded-3xl p-6 sm:p-8 max-w-md w-full shadow-2xl border border-slate-200 space-y-5">
              <div className="flex items-center justify-between border-b border-slate-100 pb-3">
                <h3 className="text-sm font-bold text-slate-900">Invite Corporate Team Member</h3>
                <button onClick={() => setInviteModalOpen(false)} className="text-slate-400 hover:text-slate-600 font-bold">✕</button>
              </div>

              <form onSubmit={handleInviteSubmit} className="space-y-4 text-xs">
                <div className="space-y-1">
                  <label className="font-bold text-slate-800">Full Name *</label>
                  <input
                    type="text"
                    required
                    value={inviteName}
                    onChange={(e) => setInviteName(e.target.value)}
                    placeholder="e.g. Asim Riaz"
                    className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                  />
                </div>

                <div className="space-y-1">
                  <label className="font-bold text-slate-800">Corporate Email Address *</label>
                  <input
                    type="email"
                    required
                    value={inviteEmail}
                    onChange={(e) => setInviteEmail(e.target.value)}
                    placeholder="asim@company.com"
                    className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                  />
                </div>

                <div className="space-y-1">
                  <label className="font-bold text-slate-800">Department</label>
                  <select
                    value={inviteDept}
                    onChange={(e) => setInviteDept(e.target.value)}
                    className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                  >
                    <option value="Human Resources">Human Resources (HR)</option>
                    <option value="Legal & Compliance">Legal & Compliance</option>
                    <option value="Procurement & Vendor Ops">Procurement & Vendor Ops</option>
                    <option value="Finance & Accounts">Finance & Accounts</option>
                  </select>
                </div>

                <div className="flex items-center justify-end gap-2 pt-3 border-t border-slate-100">
                  <button
                    type="button"
                    onClick={() => setInviteModalOpen(false)}
                    className="px-4 py-2 font-semibold text-slate-600 hover:bg-slate-100 rounded-xl"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    className="px-4 py-2 bg-emerald-700 hover:bg-emerald-800 text-white font-bold rounded-xl shadow-sm"
                  >
                    Send Invitation
                  </button>
                </div>
              </form>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
