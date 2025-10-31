// src/lib/auth.ts
export interface AuthResponse {
  headers: Headers;
  json: any;
}

// バックエンドの URL に合わせる
const API_BASE = "http://localhost:3002/api/v1/auth";

// Headers オブジェクトを受け取るように修正
export const saveAuthHeaders = (headers: Headers) => {
  const accessToken = headers.get("access-token");
  const client = headers.get("client");
  const uid = headers.get("uid");

  if (accessToken && client && uid) {
    localStorage.setItem("access-token", accessToken);
    localStorage.setItem("client", client);
    localStorage.setItem("uid", uid);
  }
};

// 共通の POST ヘルパー
const apiPost = async (url: string, body: object): Promise<AuthResponse> => {
  const res = await fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });

  const data = await res.json().catch(() => null);

  if (!res.ok) {
    throw new Error(data?.errors?.[0] || `Request failed with status ${res.status}`);
  }

  return { headers: res.headers, json: data };
};

// auth.ts
export const signIn = async (email: string, password: string) => {
  const res = await apiPost(`${API_BASE}/sign_in`, { email, password });
  saveAuthHeaders(res.headers as Headers); // ← 型キャストで赤線消える
  return res.json;
};

export const signUp = async (email: string, password: string, password_confirmation: string) => {
  const res = await apiPost(`${API_BASE}`, { email, password, password_confirmation });
  saveAuthHeaders(res.headers as Headers);
  return res.json;
};

