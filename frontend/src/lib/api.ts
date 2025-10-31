const API_BASE_URL = "http://localhost:3002/api/v1";

export const apiPost = async (path: string, body: object) => {
  const res = await fetch(`${API_BASE_URL}${path}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });

  if (!res.ok) {
    const errorData = await res.json().catch(() => null);
    throw new Error(errorData?.errors?.[0] || `Request failed with status ${res.status}`);
  }

  return res;
};
