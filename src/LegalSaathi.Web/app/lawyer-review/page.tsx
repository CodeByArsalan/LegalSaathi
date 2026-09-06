"use client";

import React, { useState, useEffect, Suspense } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import {
  ShieldCheck,
  Search,
  Filter,
  Star,
  Award,
  Clock,
  MapPin,
  CheckCircle2,
  AlertCircle,
  FileText,
  UserCheck,
  Send,
  Sparkles,
  ChevronRight,
  PlusCircle,
  Info,
  Calendar,
  ExternalLink,
  Scale,
  MessageSquare,
  CheckCheck
} from "lucide-react";
import { apiClient } from "@/lib/api-client";
import { useAuth } from "@/lib/auth-context";

interface LawyerDto {
  lawyerId: number;
  userId: number;
  fullName: string;
  email: string;
  phoneNumber?: string;
  barCouncilNumber: string;
  province: string;
  city: string;
  specialization: string;
  yearsOfExperience: number;
  enrollmentLevel: string;
  rating: number;
  reviewCount: number;
  bio?: string;
  isVerified: boolean;
}

interface LawyerReviewDto {
  reviewId: number;
  userDocumentId: number;
  documentTitle: string;
  templateTitleEn: string;
  templateTitleUr: string;
  userId: number;
  clientName: string;
  lawyerId?: number;
  lawyerName?: string;
  barCouncilNumber?: string;
  lawyerSpecialization?: string;
  statusId: number;
  statusName: string;
  fee: number;
  isPaid: boolean;
  notes?: string;
  lawyerNotes?: string;
  annotatedPdfPath?: string;
  createdAt: string;
  completedAt?: string;
}

interface UserDocOption {
  userDocumentId: number;
  title: string;
  templateTitleEn: string;
  status: string;
}

function LawyerReviewContent() {
  const searchParams = useSearchParams();
  const { isAuthenticated, user } = useAuth();

  const [activeTab, setActiveTab] = useState<"directory" | "my-reviews" | "submit" | "assigned-reviews">("directory");

  // Directory state
  const [lawyers, setLawyers] = useState<LawyerDto[]>([]);
  const [loadingLawyers, setLoadingLawyers] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedProvince, setSelectedProvince] = useState("all");
  const [selectedSpecialization, setSelectedSpecialization] = useState("all");

  // Client Reviews state
  const [myReviews, setMyReviews] = useState<LawyerReviewDto[]>([]);
  const [loadingReviews, setLoadingReviews] = useState(false);

  // Advocate Assigned Reviews state
  const [assignedReviews, setAssignedReviews] = useState<LawyerReviewDto[]>([]);
  const [loadingAssigned, setLoadingAssigned] = useState(false);
  const [selectedAssignedReview, setSelectedAssignedReview] = useState<LawyerReviewDto | null>(null);
  const [feedbackNotes, setFeedbackNotes] = useState("");
  const [feedbackStatusId, setFeedbackStatusId] = useState<number>(5); // Default 5: ApprovedAndStamped
  const [isSubmittingFeedback, setIsSubmittingFeedback] = useState(false);
  const [feedbackSuccess, setFeedbackSuccess] = useState<string | null>(null);
  const [feedbackError, setFeedbackError] = useState<string | null>(null);

  // Submit state
  const [userDocs, setUserDocs] = useState<UserDocOption[]>([]);
  const [submitDocId, setSubmitDocId] = useState<number | undefined>(undefined);
  const [submitLawyerId, setSubmitLawyerId] = useState<number | undefined>(undefined);
  const [submitNotes, setSubmitNotes] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitSuccessMsg, setSubmitSuccessMsg] = useState<string | null>(null);
  const [submitErrorMsg, setSubmitErrorMsg] = useState<string | null>(null);

  // Read URL search params
  useEffect(() => {
    const docParam = searchParams.get("docId");
    const tabParam = searchParams.get("tab");

    if (tabParam === "submit" || tabParam === "my-reviews" || tabParam === "directory" || tabParam === "assigned-reviews") {
      setActiveTab(tabParam as any);
    }
    if (docParam) {
      const parsedId = parseInt(docParam, 10);
      if (!isNaN(parsedId)) {
        setSubmitDocId(parsedId);
      }
    }
  }, [searchParams]);

  // Load Lawyers Directory
  useEffect(() => {
    async function fetchLawyers() {
      setLoadingLawyers(true);
      try {
        const queryParams = [];
        if (selectedProvince !== "all") queryParams.push("province=" + encodeURIComponent(selectedProvince));
        if (selectedSpecialization !== "all") queryParams.push("specialization=" + encodeURIComponent(selectedSpecialization));
        const qs = queryParams.length ? "?" + queryParams.join("&") : "";

        const res = await apiClient.get<LawyerDto[]>("/api/lawyers" + qs);
        if (res.success && res.data) {
          setLawyers(res.data);
        }
      } catch (e) {
        // ignore
      } finally {
        setLoadingLawyers(false);
      }
    }
    fetchLawyers();
  }, [selectedProvince, selectedSpecialization]);

  // Load User Reviews
  useEffect(() => {
    if (activeTab === "my-reviews" && isAuthenticated) {
      loadMyReviews();
    } else if (activeTab === "assigned-reviews" && isAuthenticated) {
      loadAssignedReviews();
    }
  }, [activeTab, isAuthenticated]);

  // Load User Docs for submission
  useEffect(() => {
    const loadDocs = async () => {
      if (isAuthenticated) {
        try {
          const res = await apiClient.get<UserDocOption[]>("/api/documents");
          if (res.success && res.data) {
            setUserDocs(res.data);
          }
        } catch (e) {
          // ignore
        }
      }
    };
    loadDocs();
  }, [isAuthenticated]);

  const loadMyReviews = async () => {
    setLoadingReviews(true);
    try {
      const res = await apiClient.get<LawyerReviewDto[]>("/api/lawyers/reviews/my");
      if (res.success && res.data) {
        setMyReviews(res.data);
      }
    } catch (e) {
      // ignore
    } finally {
      setLoadingReviews(false);
    }
  };

  const loadAssignedReviews = async () => {
    setLoadingAssigned(true);
    try {
      const res = await apiClient.get<LawyerReviewDto[]>("/api/lawyers/reviews/assigned");
      if (res.success && res.data) {
        setAssignedReviews(res.data);
      }
    } catch (e) {
      // ignore
    } finally {
      setLoadingAssigned(false);
    }
  };

  const handleSelectLawyerForReview = (lawyer: LawyerDto) => {
    setSubmitLawyerId(lawyer.lawyerId);
    setActiveTab("submit");
  };

  const handleSubmitReviewRequest = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!submitDocId) {
      setSubmitErrorMsg("Please select a document to submit for lawyer review.");
      return;
    }

    setIsSubmitting(true);
    setSubmitSuccessMsg(null);
    setSubmitErrorMsg(null);

    try {
      const res = await apiClient.post<LawyerReviewDto>("/api/lawyers/reviews", {
        userDocumentId: submitDocId,
        lawyerId: submitLawyerId,
        notes: submitNotes
      });

      if (res.success) {
        setSubmitSuccessMsg("Your document has been submitted for Free Lawyer Review! Our verified advocate will review it shortly.");
        setSubmitNotes("");
        setSubmitDocId(undefined);
        setSubmitLawyerId(undefined);
        setTimeout(() => {
          setActiveTab("my-reviews");
        }, 1500);
      } else {
        setSubmitErrorMsg(res.message || "Failed to submit review request.");
      }
    } catch (err: any) {
      setSubmitErrorMsg(err.message || "An error occurred while submitting review request.");
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleSubmitAdvocateFeedback = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedAssignedReview) return;

    setIsSubmittingFeedback(true);
    setFeedbackSuccess(null);
    setFeedbackError(null);

    try {
      const res = await apiClient.put<boolean>(`/api/lawyers/reviews/${selectedAssignedReview.reviewId}/feedback`, {
        lawyerNotes: feedbackNotes,
        statusId: feedbackStatusId
      });

      if (res.success) {
        setFeedbackSuccess("Advocate review notes and legal compliance status updated successfully!");
        setTimeout(() => {
          setSelectedAssignedReview(null);
          setFeedbackNotes("");
          loadAssignedReviews();
        }, 1200);
      } else {
        setFeedbackError(res.message || "Failed to submit advocate feedback.");
      }
    } catch (err: any) {
      setFeedbackError(err.message || "Error submitting feedback.");
    } finally {
      setIsSubmittingFeedback(false);
    }
  };

  const filteredLawyers = lawyers.filter((l) => {
    const q = searchTerm.toLowerCase();
    return (
      l.fullName.toLowerCase().includes(q) ||
      l.barCouncilNumber.toLowerCase().includes(q) ||
      l.city.toLowerCase().includes(q) ||
      l.specialization.toLowerCase().includes(q)
    );
  });

  const getStatusBadge = (statusName: string, statusId: number) => {
    switch (statusId) {
      case 1: // Requested
        return <span className="text-xs bg-amber-100 text-amber-800 font-bold px-2.5 py-1 rounded-full border border-amber-200">Pending Assignment</span>;
      case 2: // Assigned
      case 3: // InReview / InProgress
        return <span className="text-xs bg-sky-100 text-sky-800 font-bold px-2.5 py-1 rounded-full border border-sky-200">In Review</span>;
      case 4: // ChangesSuggested
        return <span className="text-xs bg-amber-100 text-amber-900 font-bold px-2.5 py-1 rounded-full border border-amber-300">Changes Suggested</span>;
      case 5: // ApprovedAndStamped
        return <span className="text-xs bg-emerald-100 text-emerald-800 font-bold px-2.5 py-1 rounded-full border border-emerald-200">Certified Compliant</span>;
      case 6: // Rejected
        return <span className="text-xs bg-rose-100 text-rose-800 font-bold px-2.5 py-1 rounded-full border border-rose-200">Rejected</span>;
      default:
        return <span className="text-xs bg-purple-100 text-purple-800 font-bold px-2.5 py-1 rounded-full border border-purple-200">{statusName}</span>;
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Banner */}
        <div className="bg-gradient-to-r from-emerald-900 via-slate-900 to-teal-950 rounded-2xl p-6 text-white shadow-xl flex flex-col md:flex-row items-start md:items-center justify-between gap-4 border border-emerald-800/30">
          <div className="space-y-1.5">
            <div className="flex items-center gap-2.5">
              <div className="w-10 h-10 rounded-xl bg-emerald-500/20 border border-emerald-400/30 flex items-center justify-center text-emerald-300">
                <ShieldCheck className="w-5 h-5" />
              </div>
              <div>
                <h1 className="text-xl font-bold tracking-tight flex items-center gap-2">
                  Verified Advocate Directory & Free Review
                  <span className="text-xs bg-emerald-500/20 border border-emerald-400/30 text-emerald-300 font-semibold px-2 py-0.5 rounded-full">
                    ₹0 Fee Document Review
                  </span>
                </h1>
                <p className="text-xs text-slate-300">
                  Connect with licensed advocates of the High Court and Bar Councils across Pakistan for thorough legal inspection.
                </p>
              </div>
            </div>
          </div>

          {/* Tab Navigation */}
          <div className="flex flex-wrap items-center bg-slate-800/90 p-1 rounded-xl border border-slate-700 text-xs font-semibold gap-1">
            <button
              onClick={() => setActiveTab("directory")}
              className={"px-3.5 py-1.5 rounded-lg transition-all flex items-center gap-1.5 " + (activeTab === "directory" ? "bg-emerald-600 text-white shadow-sm" : "text-slate-400 hover:text-white")}
            >
              <UserCheck className="w-3.5 h-3.5" />
              <span>Advocates Directory</span>
            </button>
            <button
              onClick={() => setActiveTab("my-reviews")}
              className={"px-3.5 py-1.5 rounded-lg transition-all flex items-center gap-1.5 " + (activeTab === "my-reviews" ? "bg-emerald-600 text-white shadow-sm" : "text-slate-400 hover:text-white")}
            >
              <Clock className="w-3.5 h-3.5" />
              <span>My Reviews</span>
            </button>
            <button
              onClick={() => setActiveTab("submit")}
              className={"px-3.5 py-1.5 rounded-lg transition-all flex items-center gap-1.5 " + (activeTab === "submit" ? "bg-emerald-600 text-white shadow-sm" : "text-slate-400 hover:text-white")}
            >
              <PlusCircle className="w-3.5 h-3.5" />
              <span>Submit Document</span>
            </button>
            <button
              onClick={() => setActiveTab("assigned-reviews")}
              className={"px-3.5 py-1.5 rounded-lg transition-all flex items-center gap-1.5 " + (activeTab === "assigned-reviews" ? "bg-emerald-600 text-white shadow-sm" : "text-slate-400 hover:text-white")}
            >
              <Scale className="w-3.5 h-3.5" />
              <span>Advocate Workspace</span>
            </button>
          </div>
        </div>

        {/* TAB 1: ADVOCATE DIRECTORY */}
        {activeTab === "directory" && (
          <div className="space-y-6">
            {/* Filter & Search Bar */}
            <div className="bg-white rounded-2xl p-4 border border-slate-200 shadow-sm grid grid-cols-1 md:grid-cols-3 gap-3">
              <div className="relative">
                <Search className="w-4 h-4 text-slate-400 absolute left-3 top-3" />
                <input
                  type="text"
                  placeholder="Search by name, city, bar council..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="w-full pl-9 pr-3 py-2 text-xs bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                />
              </div>

              <div>
                <select
                  value={selectedProvince}
                  onChange={(e) => setSelectedProvince(e.target.value)}
                  className="w-full py-2 px-3 text-xs bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                >
                  <option value="all">All Provinces / تمام صوبے</option>
                  <option value="Punjab">Punjab</option>
                  <option value="Sindh">Sindh</option>
                  <option value="Khyber Pakhtunkhwa">Khyber Pakhtunkhwa</option>
                  <option value="Islamabad Capital Territory">Islamabad Capital Territory</option>
                  <option value="Balochistan">Balochistan</option>
                </select>
              </div>

              <div>
                <select
                  value={selectedSpecialization}
                  onChange={(e) => setSelectedSpecialization(e.target.value)}
                  className="w-full py-2 px-3 text-xs bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:outline-none"
                >
                  <option value="all">All Specializations / تمام شعبے</option>
                  <option value="Real Estate & Tenancy">Real Estate & Tenancy</option>
                  <option value="Corporate & Commercial">Corporate & Commercial</option>
                  <option value="Civil & Family Law">Civil & Family Law</option>
                  <option value="Taxation & Customs">Taxation & Customs</option>
                  <option value="IP & Cyber Law">IP & Cyber Law</option>
                </select>
              </div>
            </div>

            {/* Advocate Cards Grid */}
            {loadingLawyers ? (
              <div className="text-center py-16">
                <div className="w-8 h-8 border-3 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto mb-3" />
                <p className="text-xs text-slate-500">Loading verified Bar Council advocates...</p>
              </div>
            ) : filteredLawyers.length === 0 ? (
              <div className="bg-white rounded-2xl p-12 text-center border border-slate-200 shadow-sm space-y-2">
                <AlertCircle className="w-8 h-8 text-slate-400 mx-auto" />
                <p className="text-sm font-bold text-slate-800">No advocates match your filter criteria.</p>
                <p className="text-xs text-slate-500">Try resetting the province or specialization filter.</p>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {filteredLawyers.map((l) => (
                  <div
                    key={l.lawyerId}
                    className="bg-white rounded-2xl p-5 border border-slate-200 shadow-sm hover:shadow-md transition-all flex flex-col justify-between space-y-4"
                  >
                    <div className="space-y-3">
                      {/* Top Row: Name & Verification */}
                      <div className="flex items-start justify-between gap-2">
                        <div>
                          <h3 className="text-sm font-bold text-slate-900 flex items-center gap-1.5">
                            {l.fullName}
                            {l.isVerified && (
                              <CheckCircle2 className="w-4 h-4 text-emerald-600 fill-emerald-100" />
                            )}
                          </h3>
                          <span className="text-[11px] text-emerald-700 font-semibold block">
                            {l.enrollmentLevel}
                          </span>
                        </div>
                        <div className="flex items-center gap-1 bg-amber-50 border border-amber-200 px-2 py-0.5 rounded-lg text-amber-800 font-bold text-xs">
                          <Star className="w-3 h-3 fill-amber-500 text-amber-500" />
                          <span>{l.rating.toFixed(1)}</span>
                        </div>
                      </div>

                      {/* Bar Council & Location */}
                      <div className="space-y-1 text-xs text-slate-600">
                        <div className="flex items-center gap-1.5">
                          <Award className="w-3.5 h-3.5 text-slate-400 shrink-0" />
                          <span className="font-mono text-[11px]">BC: {l.barCouncilNumber}</span>
                        </div>
                        <div className="flex items-center gap-1.5">
                          <MapPin className="w-3.5 h-3.5 text-slate-400 shrink-0" />
                          <span>{l.city}, {l.province}</span>
                        </div>
                        <div className="flex items-center gap-1.5">
                          <Clock className="w-3.5 h-3.5 text-slate-400 shrink-0" />
                          <span>{l.yearsOfExperience} Years Experience</span>
                        </div>
                      </div>

                      {/* Specialization Tag */}
                      <div>
                        <span className="inline-block text-[11px] font-semibold bg-slate-100 text-slate-700 px-2.5 py-1 rounded-lg border border-slate-200">
                          {l.specialization}
                        </span>
                      </div>

                      {/* Bio */}
                      {l.bio && (
                        <p className="text-[11px] text-slate-500 line-clamp-2 leading-relaxed">
                          {l.bio}
                        </p>
                      )}
                    </div>

                    {/* Bottom Action */}
                    <div className="pt-3 border-t border-slate-100 flex items-center justify-between">
                      <div className="text-[11px] text-emerald-700 font-bold">
                        Free Review (₹0)
                      </div>
                      <button
                        onClick={() => handleSelectLawyerForReview(l)}
                        className="px-3.5 py-1.5 bg-emerald-700 hover:bg-emerald-800 text-white rounded-xl font-semibold text-xs shadow-sm transition-colors flex items-center gap-1"
                      >
                        <span>Request Review</span>
                        <ChevronRight className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* TAB 2: MY REVIEWS TRACKER */}
        {activeTab === "my-reviews" && (
          <div className="space-y-6">
            {!isAuthenticated ? (
              <div className="bg-white rounded-2xl p-12 text-center border border-slate-200 shadow-sm space-y-3">
                <ShieldCheck className="w-8 h-8 text-emerald-600 mx-auto" />
                <h3 className="text-sm font-bold text-slate-900">Sign in to view your submitted reviews</h3>
                <p className="text-xs text-slate-500 max-w-sm mx-auto">
                  Login to your Legal Saathi account to track advocate inspection progress, read notes, and download certified compliant copies.
                </p>
                <Link
                  href="/auth/login"
                  className="inline-block px-4 py-2 bg-emerald-700 text-white font-semibold text-xs rounded-xl shadow-sm hover:bg-emerald-800 transition-colors"
                >
                  Sign In
                </Link>
              </div>
            ) : loadingReviews ? (
              <div className="text-center py-16">
                <div className="w-8 h-8 border-3 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto mb-3" />
                <p className="text-xs text-slate-500">Fetching your document review requests...</p>
              </div>
            ) : myReviews.length === 0 ? (
              <div className="bg-white rounded-2xl p-12 text-center border border-slate-200 shadow-sm space-y-3">
                <FileText className="w-8 h-8 text-slate-400 mx-auto" />
                <h3 className="text-sm font-bold text-slate-900">No Review Requests Yet</h3>
                <p className="text-xs text-slate-500 max-w-md mx-auto">
                  You have not submitted any legal documents for advocate review yet. Select one of your drafted contracts to receive a free certified opinion.
                </p>
                <button
                  onClick={() => setActiveTab("submit")}
                  className="inline-flex items-center gap-1.5 px-4 py-2 bg-emerald-700 text-white font-semibold text-xs rounded-xl shadow-sm hover:bg-emerald-800 transition-colors"
                >
                  <PlusCircle className="w-3.5 h-3.5" />
                  <span>Submit Document for Review</span>
                </button>
              </div>
            ) : (
              <div className="space-y-4">
                {myReviews.map((rev) => (
                  <div
                    key={rev.reviewId}
                    className="bg-white rounded-2xl p-5 border border-slate-200 shadow-sm space-y-4"
                  >
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-3 border-b border-slate-100">
                      <div>
                        <div className="flex items-center gap-2">
                          <h3 className="text-sm font-bold text-slate-900">
                            {rev.documentTitle || rev.templateTitleEn}
                          </h3>
                          <span className="text-[11px] text-slate-400 font-mono">
                            #REV-{rev.reviewId}
                          </span>
                        </div>
                        <p className="text-xs text-slate-500">
                          Template: {rev.templateTitleEn} / {rev.templateTitleUr}
                        </p>
                      </div>
                      <div className="flex items-center gap-3">
                        {getStatusBadge(rev.statusName, rev.statusId)}
                        <span className="text-[11px] text-slate-400">
                          {new Date(rev.createdAt).toLocaleDateString()}
                        </span>
                      </div>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-xs">
                      {/* Advocate Info */}
                      <div className="bg-slate-50 p-3 rounded-xl border border-slate-100 space-y-1">
                        <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">
                          Assigned Advocate
                        </span>
                        <p className="font-bold text-slate-900">
                          {rev.lawyerName || "Pending Advocate Assignment"}
                        </p>
                        {rev.barCouncilNumber && (
                          <p className="text-[11px] text-slate-600">
                            Bar Council: {rev.barCouncilNumber} ({rev.lawyerSpecialization})
                          </p>
                        )}
                      </div>

                      {/* User Notes */}
                      <div className="bg-slate-50 p-3 rounded-xl border border-slate-100 space-y-1">
                        <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">
                          Your Instructions / Concerns
                        </span>
                        <p className="text-[11px] text-slate-700 italic">
                          {rev.notes || "No special instructions provided."}
                        </p>
                      </div>
                    </div>

                    {/* Lawyer Feedback if available */}
                    {rev.lawyerNotes && (
                      <div className="bg-emerald-50/70 border border-emerald-200 p-4 rounded-xl space-y-2">
                        <div className="flex items-center gap-1.5 text-emerald-900 font-bold text-xs">
                          <ShieldCheck className="w-4 h-4 text-emerald-600" />
                          <span>Advocate Legal Assessment & Notes:</span>
                        </div>
                        <p className="text-xs text-emerald-950 leading-relaxed whitespace-pre-wrap">
                          {rev.lawyerNotes}
                        </p>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* TAB 3: SUBMIT FOR REVIEW */}
        {activeTab === "submit" && (
          <div className="max-w-2xl mx-auto bg-white rounded-2xl p-6 sm:p-8 border border-slate-200 shadow-sm space-y-6">
            <div className="space-y-1 border-b border-slate-100 pb-4">
              <h2 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <FileText className="w-5 h-5 text-emerald-600" />
                Submit Document for Free Advocate Review
              </h2>
              <p className="text-xs text-slate-500">
                A verified High Court advocate will check your contract for statutory compliance, valid stamp duty, and enforceable dispute clauses.
              </p>
            </div>

            {submitSuccessMsg && (
              <div className="bg-emerald-50 border border-emerald-200 p-4 rounded-xl flex items-center gap-3 text-xs text-emerald-800 font-semibold">
                <CheckCircle2 className="w-5 h-5 text-emerald-600 shrink-0" />
                <span>{submitSuccessMsg}</span>
              </div>
            )}

            {submitErrorMsg && (
              <div className="bg-rose-50 border border-rose-200 p-4 rounded-xl flex items-center gap-3 text-xs text-rose-800 font-semibold">
                <AlertCircle className="w-5 h-5 text-rose-600 shrink-0" />
                <span>{submitErrorMsg}</span>
              </div>
            )}

            <form onSubmit={handleSubmitReviewRequest} className="space-y-5">
              {/* Select Document */}
              <div className="space-y-1.5">
                <label className="text-xs font-bold text-slate-800 block">
                  Select Document to Review *
                </label>
                {userDocs.length > 0 ? (
                  <select
                    value={submitDocId || ""}
                    onChange={(e) => setSubmitDocId(e.target.value ? Number(e.target.value) : undefined)}
                    required
                    className="w-full text-xs bg-slate-50 border border-slate-200 rounded-xl p-3 text-slate-800 focus:outline-none focus:ring-2 focus:ring-emerald-500"
                  >
                    <option value="">-- Choose one of your drafted documents --</option>
                    {userDocs.map((d) => (
                      <option key={d.userDocumentId} value={d.userDocumentId}>
                        {d.title || d.templateTitleEn} (#{d.userDocumentId}) - Status: {d.status}
                      </option>
                    ))}
                  </select>
                ) : (
                  <div className="p-4 bg-slate-50 rounded-xl border border-slate-200 text-xs text-slate-600 space-y-2">
                    <p>You haven't generated any legal documents yet.</p>
                    <Link
                      href="/templates"
                      className="inline-block text-emerald-700 font-bold hover:underline"
                    >
                      Browse Templates & Create Your First Document &rarr;
                    </Link>
                  </div>
                )}
              </div>

              {/* Select Preferred Advocate */}
              <div className="space-y-1.5">
                <label className="text-xs font-bold text-slate-800 block">
                  Preferred Advocate (Optional)
                </label>
                <select
                  value={submitLawyerId || ""}
                  onChange={(e) => setSubmitLawyerId(e.target.value ? Number(e.target.value) : undefined)}
                  className="w-full text-xs bg-slate-50 border border-slate-200 rounded-xl p-3 text-slate-800 focus:outline-none focus:ring-2 focus:ring-emerald-500"
                >
                  <option value="">Auto-Assign to Available Bar Council Specialist</option>
                  {lawyers.map((l) => (
                    <option key={l.lawyerId} value={l.lawyerId}>
                      {l.fullName} ({l.city} - {l.specialization})
                    </option>
                  ))}
                </select>
              </div>

              {/* Specific Questions / Notes */}
              <div className="space-y-1.5">
                <label className="text-xs font-bold text-slate-800 block">
                  Specific Questions / Concerns for the Advocate
                </label>
                <textarea
                  rows={4}
                  value={submitNotes}
                  onChange={(e) => setSubmitNotes(e.target.value)}
                  placeholder="e.g. Please check if the termination clause in Section 7 is compliant with Punjab tenancy laws, and verify if ₹100 stamp duty is sufficient."
                  className="w-full text-xs bg-slate-50 border border-slate-200 rounded-xl p-3 text-slate-800 focus:outline-none focus:ring-2 focus:ring-emerald-500"
                />
              </div>

              {/* Fee Notice */}
              <div className="bg-emerald-50 border border-emerald-200/80 rounded-xl p-4 flex items-center justify-between">
                <div>
                  <span className="text-xs font-bold text-emerald-900 block">
                    Review Fee: Free (₹0)
                  </span>
                  <span className="text-[11px] text-emerald-700">
                    Sponsored under the Legal Saathi Access to Justice Initiative.
                  </span>
                </div>
                <div className="w-7 h-7 rounded-full bg-emerald-600 text-white flex items-center justify-center font-bold text-xs">
                  ✓
                </div>
              </div>

              {/* Submit Button */}
              <button
                type="submit"
                disabled={isSubmitting || userDocs.length === 0}
                className="w-full py-3 bg-emerald-700 hover:bg-emerald-800 disabled:opacity-50 text-white font-bold text-xs rounded-xl shadow-sm transition-all flex items-center justify-center gap-2"
              >
                {isSubmitting ? (
                  <>
                    <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                    <span>Submitting to Advocate...</span>
                  </>
                ) : (
                  <>
                    <Send className="w-4 h-4" />
                    <span>Submit for Free Review</span>
                  </>
                )}
              </button>
            </form>
          </div>
        )}

        {/* TAB 4: ADVOCATE REVIEWER WORKSPACE */}
        {activeTab === "assigned-reviews" && (
          <div className="space-y-6">
            <div className="bg-white rounded-2xl p-6 border border-slate-200 shadow-sm flex items-center justify-between">
              <div>
                <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2">
                  <Scale className="w-4 h-4 text-emerald-700" />
                  Advocate Assigned Document Review Queue
                </h2>
                <p className="text-xs text-slate-500 mt-0.5">
                  Inspect submitted legal contracts, examine client instructions, and issue certified compliance or suggested revisions.
                </p>
              </div>
              <button
                onClick={loadAssignedReviews}
                className="px-3 py-1.5 text-xs font-semibold bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl transition-colors"
              >
                Refresh Queue
              </button>
            </div>

            {loadingAssigned ? (
              <div className="text-center py-16">
                <div className="w-8 h-8 border-3 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto mb-3" />
                <p className="text-xs text-slate-500">Loading assigned review tickets...</p>
              </div>
            ) : assignedReviews.length === 0 ? (
              <div className="bg-white rounded-2xl p-12 text-center border border-slate-200 shadow-sm space-y-2">
                <Scale className="w-8 h-8 text-slate-400 mx-auto" />
                <p className="text-sm font-bold text-slate-800">No Review Requests In Your Queue</p>
                <p className="text-xs text-slate-500">
                  New documents submitted by clients for your bar specialization will appear here.
                </p>
              </div>
            ) : (
              <div className="grid grid-cols-1 gap-4">
                {assignedReviews.map((rev) => (
                  <div
                    key={rev.reviewId}
                    className="bg-white rounded-2xl p-5 border border-slate-200 shadow-sm space-y-4"
                  >
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-3 border-b border-slate-100">
                      <div>
                        <div className="flex items-center gap-2">
                          <h3 className="text-sm font-bold text-slate-900">
                            {rev.documentTitle || rev.templateTitleEn}
                          </h3>
                          <span className="text-[11px] text-slate-400 font-mono">
                            #REV-{rev.reviewId}
                          </span>
                        </div>
                        <p className="text-xs text-slate-500">
                          Client: <span className="font-semibold text-slate-700">{rev.clientName}</span> • Template: {rev.templateTitleEn}
                        </p>
                      </div>
                      <div className="flex items-center gap-3">
                        {getStatusBadge(rev.statusName, rev.statusId)}
                        <span className="text-[11px] text-slate-400">
                          {new Date(rev.createdAt).toLocaleString()}
                        </span>
                      </div>
                    </div>

                    <div className="bg-slate-50 p-3.5 rounded-xl border border-slate-100 space-y-1.5 text-xs">
                      <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">
                        Client Inquiries & Concerns
                      </span>
                      <p className="text-slate-800 italic">
                        {rev.notes || "No special instructions provided by client."}
                      </p>
                    </div>

                    {rev.lawyerNotes && (
                      <div className="bg-emerald-50/70 border border-emerald-200 p-3 rounded-xl text-xs space-y-1">
                        <span className="font-bold text-emerald-900 text-[11px] block">
                          Current Advocate Assessment:
                        </span>
                        <p className="text-emerald-950 whitespace-pre-wrap">{rev.lawyerNotes}</p>
                      </div>
                    )}

                    <div className="flex flex-wrap items-center justify-between gap-3 pt-2">
                      <Link
                        href={`/documents/${rev.userDocumentId}`}
                        target="_blank"
                        className="inline-flex items-center gap-1 text-xs font-semibold text-emerald-700 hover:underline"
                      >
                        <FileText className="w-3.5 h-3.5" /> View Draft Document & Form Answers &rarr;
                      </Link>

                      <button
                        onClick={() => {
                          setSelectedAssignedReview(rev);
                          setFeedbackNotes(rev.lawyerNotes || "");
                          setFeedbackStatusId(rev.statusId === 1 || rev.statusId === 2 ? 5 : rev.statusId);
                        }}
                        className="px-4 py-2 bg-slate-900 hover:bg-slate-800 text-white rounded-xl text-xs font-bold shadow-sm transition-colors flex items-center gap-1.5"
                      >
                        <MessageSquare className="w-3.5 h-3.5 text-emerald-400" />
                        <span>Provide Advocate Feedback / Stamp</span>
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            )}

            {/* Modal: Advocate Feedback Submission */}
            {selectedAssignedReview && (
              <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-xs z-50 flex items-center justify-center p-4">
                <div className="bg-white rounded-3xl p-6 sm:p-8 max-w-xl w-full shadow-2xl border border-slate-200 space-y-5">
                  <div className="flex items-center justify-between border-b border-slate-100 pb-3">
                    <div>
                      <h3 className="text-base font-bold text-slate-900">
                        Advocate Legal Review & Stamping
                      </h3>
                      <p className="text-xs text-slate-500">
                        Reviewing {selectedAssignedReview.documentTitle} for {selectedAssignedReview.clientName}
                      </p>
                    </div>
                    <button
                      onClick={() => setSelectedAssignedReview(null)}
                      className="text-slate-400 hover:text-slate-600 text-lg font-bold"
                    >
                      ✕
                    </button>
                  </div>

                  {feedbackSuccess && (
                    <div className="p-3 bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-xl text-xs font-semibold flex items-center gap-2">
                      <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                      <span>{feedbackSuccess}</span>
                    </div>
                  )}

                  {feedbackError && (
                    <div className="p-3 bg-rose-50 border border-rose-200 text-rose-800 rounded-xl text-xs font-semibold flex items-center gap-2">
                      <AlertCircle className="w-4 h-4 text-rose-600 shrink-0" />
                      <span>{feedbackError}</span>
                    </div>
                  )}

                  <form onSubmit={handleSubmitAdvocateFeedback} className="space-y-4">
                    <div className="space-y-1.5">
                      <label className="text-xs font-bold text-slate-800 block">
                        Compliance Assessment Status *
                      </label>
                      <select
                        value={feedbackStatusId}
                        onChange={(e) => setFeedbackStatusId(Number(e.target.value))}
                        className="w-full text-xs bg-slate-50 border border-slate-200 rounded-xl p-3 text-slate-800 focus:outline-none focus:ring-2 focus:ring-emerald-500"
                      >
                        <option value={5}>Certified Compliant & Approved (LawyerApproved)</option>
                        <option value={4}>Changes / Revisions Suggested</option>
                        <option value={6}>Rejected (Non-Compliant)</option>
                      </select>
                    </div>

                    <div className="space-y-1.5">
                      <label className="text-xs font-bold text-slate-800 block">
                        Advocate Legal Opinion & Notes *
                      </label>
                      <textarea
                        rows={5}
                        required
                        value={feedbackNotes}
                        onChange={(e) => setFeedbackNotes(e.target.value)}
                        placeholder="State your formal legal advice, e.g. Document reviewed against Contract Act 1872 and Punjab Tenancy Ordinance. All terms are standard and legally enforceable in courts of law."
                        className="w-full text-xs bg-slate-50 border border-slate-200 rounded-xl p-3 text-slate-800 focus:outline-none focus:ring-2 focus:ring-emerald-500"
                      />
                    </div>

                    <div className="flex items-center justify-end gap-2.5 pt-3 border-t border-slate-100">
                      <button
                        type="button"
                        onClick={() => setSelectedAssignedReview(null)}
                        className="px-4 py-2 text-xs font-semibold text-slate-600 hover:bg-slate-100 rounded-xl transition-colors"
                      >
                        Cancel
                      </button>
                      <button
                        type="submit"
                        disabled={isSubmittingFeedback}
                        className="px-5 py-2.5 bg-emerald-700 hover:bg-emerald-800 disabled:opacity-50 text-white text-xs font-bold rounded-xl shadow-sm transition-all flex items-center gap-1.5"
                      >
                        {isSubmittingFeedback ? "Updating..." : "Submit Advocate Opinion"}
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}

export default function LawyerReviewPage() {
  return (
    <Suspense fallback={<div className="min-h-screen flex items-center justify-center text-xs text-slate-500">Loading lawyer review portal...</div>}>
      <LawyerReviewContent />
    </Suspense>
  );
}
