"use client";

import React, { createContext, useContext, useState, useEffect, useCallback } from "react";
import { User, AuthResponse, UserRole } from "@/types/auth";
import { apiClient } from "./api-client";

interface AuthContextType {
  user: User | null;
  accessToken: string | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  login: (emailOrPhone: string, password?: string) => Promise<{ success: boolean; error?: string; requiresEmailVerification?: boolean; unverifiedEmail?: string }>;
  register: (payload: {
    fullName: string;
    email: string;
    phoneNumber: string;
    password: string;
    cnic?: string;
    role: UserRole;
  }) => Promise<{ success: boolean; error?: string; requiresEmailVerification?: boolean; email?: string }>;
  verifyEmail: (email: string, otpCode: string) => Promise<{ success: boolean; error?: string }>;
  resendVerificationEmail: (email: string) => Promise<{ success: boolean; message?: string; error?: string }>;
  logout: () => Promise<void>;
  updateProfile: (data: { fullName: string; phoneNumber: string; cnic?: string }) => Promise<{ success: boolean; error?: string }>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

const TOKEN_KEY = "legal_saathi_access_token";
const REFRESH_KEY = "legal_saathi_refresh_token";
const USER_KEY = "legal_saathi_user";

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [accessToken, setAccessToken] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  // Initialize Auth state from localStorage on client load
  useEffect(() => {
    try {
      const storedToken = localStorage.getItem(TOKEN_KEY);
      const storedUser = localStorage.getItem(USER_KEY);

      if (storedToken && storedUser) {
        setAccessToken(storedToken);
        setUser(JSON.parse(storedUser));
      }
    } catch (e) {
      console.error("Failed to load stored auth credentials", e);
    } finally {
      setIsLoading(false);
    }
  }, []);

  const saveAuthSession = (auth: AuthResponse) => {
    const userData: User = {
      userId: auth.userId,
      fullName: auth.fullName,
      email: auth.email,
      phoneNumber: auth.phoneNumber,
      role: auth.role,
      cnic: auth.cnic,
      isEmailVerified: true,
      isActive: true,
    };

    setUser(userData);
    setAccessToken(auth.accessToken);

    localStorage.setItem(TOKEN_KEY, auth.accessToken);
    localStorage.setItem(REFRESH_KEY, auth.refreshToken);
    localStorage.setItem(USER_KEY, JSON.stringify(userData));
  };

  const clearAuthSession = () => {
    setUser(null);
    setAccessToken(null);
    localStorage.removeItem(TOKEN_KEY);
    localStorage.removeItem(REFRESH_KEY);
    localStorage.removeItem(USER_KEY);
  };

  const login = useCallback(async (emailOrPhone: string, password?: string) => {
    try {
      setIsLoading(true);
      const res = await apiClient.post<AuthResponse>("/api/auth/login", {
        emailOrPhone,
        password: password || "",
      });

      if (res.success && res.data) {
        saveAuthSession(res.data);
        return { success: true };
      }

      const isUnverified = res.errors?.some((e) => e.includes("not been verified") || e.includes("EmailNotVerified")) ||
                           res.message?.includes("not been verified");

      return {
        success: false,
        error: res.errors?.[0] || res.message || "Invalid login credentials",
        requiresEmailVerification: isUnverified,
        unverifiedEmail: isUnverified && emailOrPhone.includes("@") ? emailOrPhone : undefined,
      };
    } catch (err: any) {
      const errMsg = err.message || "";
      const isUnverified = errMsg.includes("not been verified") || errMsg.includes("EmailNotVerified");
      return {
        success: false,
        error: errMsg || "Network error. Please try again.",
        requiresEmailVerification: isUnverified,
        unverifiedEmail: isUnverified && emailOrPhone.includes("@") ? emailOrPhone : undefined,
      };
    } finally {
      setIsLoading(false);
    }
  }, []);

  const register = useCallback(
    async (payload: {
      fullName: string;
      email: string;
      phoneNumber: string;
      password: string;
      cnic?: string;
      role: UserRole;
    }) => {
      try {
        setIsLoading(true);
        const res = await apiClient.post<any>("/api/auth/register", payload);

        if (res.success && res.data) {
          return {
            success: true,
            requiresEmailVerification: true,
            email: payload.email,
          };
        }

        return {
          success: false,
          error: res.errors?.[0] || res.message || "Registration failed",
        };
      } catch (err: any) {
        return { success: false, error: err.message || "Network error. Please try again." };
      } finally {
        setIsLoading(false);
      }
    },
    []
  );

  const verifyEmail = useCallback(
    async (email: string, otpCode: string) => {
      try {
        setIsLoading(true);
        const res = await apiClient.post<AuthResponse>("/api/auth/verify-email", {
          email,
          otpCode,
        });

        if (res.success && res.data) {
          saveAuthSession(res.data);
          return { success: true };
        }

        return {
          success: false,
          error: res.errors?.[0] || res.message || "Verification failed",
        };
      } catch (err: any) {
        return { success: false, error: err.message || "Failed to verify OTP code." };
      } finally {
        setIsLoading(false);
      }
    },
    []
  );

  const resendVerificationEmail = useCallback(
    async (email: string) => {
      try {
        const res = await apiClient.post<any>("/api/auth/resend-verification", {
          email,
        });

        if (res.success) {
          return { success: true, message: res.message || "Verification code resent." };
        }

        return {
          success: false,
          error: res.errors?.[0] || res.message || "Failed to resend code.",
        };
      } catch (err: any) {
        return { success: false, error: err.message || "Failed to resend verification code." };
      }
    },
    []
  );

  const logout = useCallback(async () => {
    try {
      if (accessToken) {
        await apiClient.post("/api/auth/revoke-token", {}, {
          headers: { Authorization: `Bearer ${accessToken}` }
        }).catch(() => {});
      }
    } finally {
      clearAuthSession();
    }
  }, [accessToken]);

  const updateProfile = useCallback(
    async (data: { fullName: string; phoneNumber: string; cnic?: string }) => {
      try {
        if (!accessToken) return { success: false, error: "Not authenticated" };

        const res = await apiClient.put<any>("/api/auth/profile", data, {
          headers: { Authorization: `Bearer ${accessToken}` }
        });

        if (res.success && res.data) {
          const updated: User = {
            userId: res.data.userId,
            fullName: res.data.fullName,
            email: res.data.email,
            phoneNumber: res.data.phoneNumber,
            role: res.data.role,
            cnic: res.data.cnic,
          };
          setUser(updated);
          localStorage.setItem(USER_KEY, JSON.stringify(updated));
          return { success: true };
        }
        return { success: false, error: res.errors?.[0] || "Profile update failed" };
      } catch (err: any) {
        return { success: false, error: err.message || "Failed to update profile" };
      }
    },
    [accessToken]
  );

  return (
    <AuthContext.Provider
      value={{
        user,
        accessToken,
        isLoading,
        isAuthenticated: !!user && !!accessToken,
        login,
        register,
        verifyEmail,
        resendVerificationEmail,
        logout,
        updateProfile,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
}
