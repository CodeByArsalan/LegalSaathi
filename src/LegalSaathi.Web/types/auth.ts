export type UserRole = "SuperAdmin" | "EndUser" | "CorporateAdmin" | "Lawyer";

export interface User {
  userId: number;
  fullName: string;
  email: string;
  phoneNumber: string;
  role: UserRole;
  roleId?: number;
  cnic?: string;
  isEmailVerified?: boolean;
  isActive?: boolean;
  createdDateTime?: string;
}

export interface AuthResponse {
  userId: number;
  fullName: string;
  email: string;
  phoneNumber: string;
  role: UserRole;
  cnic?: string;
  accessToken: string;
  refreshToken: string;
  expiresAt: string;
}

export interface LoginPayload {
  emailOrPhone: string;
  password?: string;
  otpCode?: string;
}

export interface RegisterPayload {
  fullName: string;
  email: string;
  phoneNumber: string;
  password?: string;
  cnic?: string;
  role: UserRole;
}

export interface RegisterResponse {
  userId: number;
  fullName: string;
  email: string;
  phoneNumber: string;
  role: UserRole;
  requiresEmailVerification: boolean;
  message: string;
}

export interface VerifyEmailPayload {
  email: string;
  otpCode: string;
}

export interface ResendVerificationPayload {
  email: string;
}
