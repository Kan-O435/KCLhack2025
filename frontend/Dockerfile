# ベースイメージ
FROM node:20-alpine

# 作業ディレクトリの設定
WORKDIR /app

# ホストからpackage.jsonなどをコピー
COPY package.json yarn.lock ./

# 依存関係のインストール
RUN yarn install

# タイムゾーン設定
ENV TZ Asia/Tokyo