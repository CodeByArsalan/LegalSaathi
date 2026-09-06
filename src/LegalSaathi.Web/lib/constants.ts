export const APP_CONFIG = {
  name: "Legal Saathi",
  taglineEn: "Pakistan's Premier Bilingual AI Legal Document Platform",
  taglineUr: "پاکستان کا پہلا دو لسانی، اے آئی سے لیس قانونی دستاویزات کا پلیٹ فارم",
  apiBaseUrl: process.env.NEXT_PUBLIC_API_BASE_URL || process.env.NEXT_PUBLIC_API_URL || "/api",
  defaultLocale: "ur" as const,
  supportedLocales: ["ur", "en"] as const,
};

export const ROUTES = {
  HOME: "/",
  TEMPLATES: "/templates",
  CATEGORY: (id: number) => `/templates/category/${id}`,
  TEMPLATE_DETAIL: (slug: string) => `/templates/${slug}`,
  CREATE_DOCUMENT: (slug: string) => `/templates/${slug}`,
  DOCUMENT_VIEW: (id: number) => `/documents/${id}`,
  DASHBOARD: "/dashboard",
  LOGIN: "/login",
  REGISTER: "/register",
  LAWYER_PORTAL: "/lawyer",
  LAWYER_REVIEW: "/lawyer-review",
  ADMIN: "/admin",
  CORPORATE: "/corporate",
  DISCLAIMER: "/disclaimer",
  PRIVACY: "/privacy",
  TERMS: "/terms",
};
