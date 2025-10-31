"use client";

import { useState, type FormEvent } from "react";
import { useRouter } from "next/navigation";
import { Mail, Lock } from "lucide-react";
import { Input } from "@/components/atoms/Input";
import { Button } from "@/components/atoms/Button";
import { ErrorMessage } from "@/components/atoms/ErrorMessage";
import { signIn, signUp } from "@/lib/auth";

interface AuthFormProps {
  isSignIn: boolean;
  toggle: () => void;
}

export function AuthForm({ isSignIn, toggle }: AuthFormProps) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmation, setConfirmation] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError("");
    setLoading(true);

    try {
      if (isSignIn) {
        await signIn(email, password);
      } else {
        await signUp(email, password, confirmation);
      }

      // サインイン後にリダイレクト
      router.replace("/dashboard");
    } catch (err: any) {
      setError(err.message || "サーバーエラー");
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      {error && <ErrorMessage message={error} />}

      <Input
        icon={Mail}
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="メールアドレス"
        required
      />

      <Input
        icon={Lock}
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="パスワード"
        required
      />

      {!isSignIn && (
        <Input
          icon={Lock}
          type="password"
          value={confirmation}
          onChange={(e) => setConfirmation(e.target.value)}
          placeholder="パスワード確認"
          required
        />
      )}

      <Button type="submit" loading={loading}>
        {isSignIn ? "ログイン" : "アカウント登録"}
      </Button>

      <div className="mt-3 text-center">
        <button
          type="button"
          onClick={toggle}
          className="text-sm text-gray-600 hover:text-gray-900 transition-colors"
        >
          {isSignIn
            ? "アカウントをお持ちでない方はこちら"
            : "すでにアカウントをお持ちの方はこちら"}
        </button>
      </div>
    </form>
  );
}
