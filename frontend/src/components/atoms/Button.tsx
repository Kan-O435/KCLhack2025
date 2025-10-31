"use client";
import React from "react";

interface ButtonProps {
  type?: "button" | "submit";
  loading?: boolean;
  children: React.ReactNode;
}

export const Button: React.FC<ButtonProps> = ({ type = "button", loading = false, children }) => {
  return (
    <button
      type={type}
      disabled={loading}
      className="w-full py-3 px-4 rounded-full bg-gray-800 text-white hover:bg-gray-700 disabled:opacity-50 flex justify-center items-center space-x-2"
    >
      {loading ? <span className="animate-spin h-5 w-5 border-2 border-white rounded-full" /> : children}
    </button>
  );
};
