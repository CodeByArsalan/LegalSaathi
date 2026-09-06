export type Locale = "ur" | "en";

export type UserRole = "EndUser" | "Lawyer" | "CorporateAdmin" | "SuperAdmin";

export interface UserProfile {
  userId: number;
  fullName: string;
  email: string;
  phoneNumber: string;
  cnic?: string;
  role: UserRole;
  isEmailVerified: boolean;
  isPhoneVerified: boolean;
}

export interface AuthSession {
  user: UserProfile;
  accessToken: string;
  refreshToken: string;
  expiresAt: string;
}

export type DocumentStatus =
  | "Draft"
  | "Completed"
  | "PendingSignature"
  | "Signed"
  | "UnderLawyerReview"
  | "LawyerApproved"
  | "Archived";

export type PaymentGatewayType = "Free" | "JazzCash" | "EasyPaisa" | "PayFast";
export type PaymentStatus = "Pending" | "Success" | "Failed" | "Refunded" | "Cancelled";
