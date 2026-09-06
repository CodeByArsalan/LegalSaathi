import { APP_CONFIG } from "./constants";

export interface ApiResponse<T = any> {
  success: boolean;
  statusCode: number;
  message: string;
  data: T | null;
  errors: string[];
  timestamp: string;
}

export class ApiError extends Error {
  statusCode: number;
  errors: string[];

  constructor(message: string, statusCode: number = 500, errors: string[] = []) {
    super(message);
    this.name = "ApiError";
    this.statusCode = statusCode;
    this.errors = errors;
  }
}

class ApiClient {
  private baseUrl: string;

  constructor() {
    this.baseUrl = APP_CONFIG.apiBaseUrl;
  }

  async request<T>(endpoint: string, options: RequestInit = {}): Promise<ApiResponse<T>> {
    const cleanBase = this.baseUrl.replace(/\/+$/, "");
    let cleanEndpoint = endpoint.startsWith("/") ? endpoint : `/${endpoint}`;
    if (cleanBase.endsWith("/api") && cleanEndpoint.startsWith("/api/")) {
      cleanEndpoint = cleanEndpoint.substring(4);
    }
    const url = `${cleanBase}${cleanEndpoint}`;

    const headers: Record<string, string> = {
      "Content-Type": "application/json",
      ...(options.headers as Record<string, string>),
    };

    try {
      let response = await fetch(url, {
        ...options,
        credentials: "include", // Pure HttpOnly cookie authentication
        headers,
      });

      // If 401 Unauthorized occurs on a non-auth endpoint, attempt a silent token refresh via HttpOnly cookie
      if (
        response.status === 401 &&
        !cleanEndpoint.includes("/auth/login") &&
        !cleanEndpoint.includes("/auth/refresh-token") &&
        !cleanEndpoint.includes("/auth/register") &&
        !cleanEndpoint.includes("/auth/verify-email")
      ) {
        try {
          const refreshUrl = `${cleanBase}/auth/refresh-token`;
          const refreshRes = await fetch(refreshUrl, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({}),
            credentials: "include",
          });

          if (refreshRes.ok) {
            // Retry original request with refreshed HttpOnly cookie
            response = await fetch(url, {
              ...options,
              credentials: "include",
              headers,
            });
          }
        } catch {
          // Ignore silent refresh error and let normal 401 flow handle it
        }
      }

      const json: ApiResponse<T> = await response.json();

      if (!response.ok || !json.success) {
        throw new ApiError(
          json.message || `HTTP Error ${response.status}`,
          json.statusCode || response.status,
          json.errors || []
        );
      }

      return json;
    } catch (err: any) {
      if (err instanceof ApiError) {
        throw err;
      }
      throw new ApiError(err.message || "Failed to communicate with Legal Saathi API server.", 500);
    }
  }

  get<T>(endpoint: string, options: RequestInit = {}) {
    return this.request<T>(endpoint, { ...options, method: "GET" });
  }

  post<T>(endpoint: string, data?: any, options: RequestInit = {}) {
    return this.request<T>(endpoint, {
      ...options,
      method: "POST",
      body: data ? JSON.stringify(data) : undefined,
    });
  }

  put<T>(endpoint: string, data?: any, options: RequestInit = {}) {
    return this.request<T>(endpoint, {
      ...options,
      method: "PUT",
      body: data ? JSON.stringify(data) : undefined,
    });
  }

  delete<T>(endpoint: string, options: RequestInit = {}) {
    return this.request<T>(endpoint, { ...options, method: "DELETE" });
  }
}

export const apiClient = new ApiClient();
