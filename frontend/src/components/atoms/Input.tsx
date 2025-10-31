"use client";
import React from "react";

export interface InputProps {
  icon: React.ElementType;
  type: string;
  value: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  placeholder: string;
  required?: boolean;
}

export const Input: React.FC<InputProps> = ({ icon: Icon, type, value, onChange, placeholder, required }) => {
  return (
    <div className="relative">
      <Icon className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
      <input
        type={type}
        value={value}
        onChange={onChange}
        placeholder={placeholder}
        required={required}
        className="w-full pl-10 pr-4 py-3 border-b-2 border-gray-200 focus:border-gray-800 outline-none rounded-none"
      />
    </div>
  );
};
