"use client";
import React from "react";
import { AuthForm } from "@/components/molecules/AuthForm";

interface AuthCardProps {
  isSignIn: boolean;
  toggle: () => void;
}

export const AuthCard: React.FC<AuthCardProps> = ({ isSignIn, toggle }) => {
  return (
    <div className="w-full max-w-md bg-white p-8 sm:p-12 rounded-xl shadow-2xl border border-gray-100 transition transform hover:scale-[1.01]">
      <div className="text-center mb-10">
        <h1 className="text-4xl font-extrabold text-gray-900 tracking-tight mb-2">{isSignIn ? "ログイン" : "新規登録"}</h1>
        <p className="text-gray-500 text-sm">Hair Plannerであなただけのヘアプランを</p>
      </div>
      <AuthForm isSignIn={isSignIn} toggle={toggle} />
    </div>
  );
};
