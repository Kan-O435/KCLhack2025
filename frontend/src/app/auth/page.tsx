"use client";
import React, { useState } from "react";
import { AuthCard } from "../../components/organisms/AuthCard";

export default function AuthPage() {
  const [isSignIn, setIsSignIn] = useState(true);

  return (
    <div className="min-h-screen flex justify-center items-center bg-gray-900 p-4">
      <AuthCard isSignIn={isSignIn} toggle={() => setIsSignIn(!isSignIn)} />
    </div>
  );
}
