# 1. ビルドステージ
FROM node:20-slim AS builder

# ワーキングディレクトリを設定
WORKDIR /app

# package.jsonとロックファイルをコピー
COPY package.json package-lock.json ./

# 依存関係をインストール
# 🔥 ピア依存関係の競合を無視するためにフラグを追加 🔥
RUN npm install --legacy-peer-deps

# アプリケーションコードをコピー
COPY . .

# Next.jsアプリケーションのビルド
RUN npm run build

# --------------------------
# ... (Runner Stage は省略)
