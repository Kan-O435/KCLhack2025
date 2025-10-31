"use client";
import React from "react";

interface ErrorMessageProps {
  message: string;
}

export const ErrorMessage: React.FC<ErrorMessageProps> = ({ message }) => (
  <div className="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 text-sm rounded-lg text-center font-medium">
    {message}
  </div>
);
