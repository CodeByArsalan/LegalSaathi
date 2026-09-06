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

  private getAuthToken(): string | null {
    if (typeof window !== "undefined") {
      return localStorage.getItem("legal_saathi_access_token") || localStorage.getItem("ls_access_token");
    }
    return null;
  }

  async request<T>(endpoint: string, options: RequestInit = {}): Promise<ApiResponse<T>> {
    const cleanBase = this.baseUrl.replace(/\/+$/, "");
    let cleanEndpoint = endpoint.startsWith("/") ? endpoint : `/${endpoint}`;
    if (cleanBase.endsWith("/api") && cleanEndpoint.startsWith("/api/")) {
      cleanEndpoint = cleanEndpoint.substring(4);
    }
    const url = `${cleanBase}${cleanEndpoint}`;
    const token = this.getAuthToken();

    const headers: Record<string, string> = {
      "Content-Type": "application/json",
      ...(options.headers as Record<string, string>),
    };

    if (token && !headers["Authorization"]) {
      headers["Authorization"] = `Bearer ${token}`;
    }


    try {
      const response = await fetch(url, {
        ...options,
        headers,
      });

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
