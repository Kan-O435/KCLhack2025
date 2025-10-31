"use client";

import React from 'react';
import { ChevronRight, Zap, Calendar, Scissors, User } from 'lucide-react';
import { useRouter } from 'next/navigation';

// アプリの主要機能データを定義
const features = [
  {
    icon: <Zap className="w-6 h-6 text-gray-400" />,
    title: '3Dモデルで理想をシミュレーション',
    description: '現在の髪型を読み込み、未来の姿を正確に予測します。'
  },
  {
    icon: <Calendar className="w-6 h-6 text-gray-400" />,
    title: '最適な散髪日を計画',
    description: '理想の長さに伸びる日を計算し、ベストな予約日を提案します。'
  },
  {
    icon: <Scissors className="w-6 h-6 text-gray-400" />,
    title: 'シームレスな予約連携',
    description: '計算結果に基づき、地域の美容室をスムーズに予約できます。'
  }
];

export default function WelcomePage() {
  const router = useRouter();

  const handleStart = () => {
    router.push('/auth');
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-center p-4 sm:p-6 font-inter bg-gradient-to-br from-gray-900 to-black">
      
      {/* ヘッダー */}
      <header className="w-full max-w-xl text-center mb-10">
        <div className="flex justify-center items-center mb-4">
          <Scissors className="w-10 h-10 text-white mr-3" />
          <h1 className="text-5xl font-extrabold tracking-tight text-white drop-shadow-lg">Hair Planner</h1>
        </div>
        <p className="text-2xl text-gray-300 mt-2 font-light">
          理想のヘアスタイルを、計画的に実現する。
        </p>
      </header>

      {/* 機能紹介セクション */}
      <main className="w-full max-w-md bg-white p-8 rounded-3xl shadow-2xl space-y-7 border border-gray-100 transform hover:scale-[1.01] transition duration-300">
        <h2 className="text-2xl font-bold text-gray-900 border-b pb-3 mb-4 border-gray-200">アプリの特徴</h2>
        {features.map((feature, index) => (
          <div key={index} className="flex items-start space-x-4">
            <div className="flex-shrink-0 p-3 bg-gray-50 rounded-full shadow-inner">
              {feature.icon}
            </div>
            <div>
              <h3 className="text-xl font-semibold text-gray-900">{feature.title}</h3>
              <p className="text-sm text-gray-600 mt-1">{feature.description}</p>
            </div>
          </div>
        ))}
      </main>

      {/* CTA (Call to Action) */}
      <div className="w-full max-w-md mt-10">
        <button
          onClick={handleStart}
          className="w-full flex items-center justify-center px-6 py-4 border border-transparent text-xl font-bold rounded-xl shadow-2xl text-gray-900 bg-white ring-2 ring-gray-200 hover:bg-gray-100 transition duration-300 transform hover:scale-[1.02]"
        >
          さあ、はじめよう！
          <ChevronRight className="w-6 h-6 ml-3" />
        </button>
      </div>

      {/* フッターリンク */}
      <footer className="mt-12 text-center">
        <p className="text-sm text-gray-400">
          すでにアカウントをお持ちですか？ 
          <button 
            onClick={() => router.push('/auth')} 
            className="text-white hover:text-gray-200 font-medium ml-1 transition duration-150"
          >
            ログイン
          </button>
        </p>
      </footer>
    </div>
  );
}
