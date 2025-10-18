# ベースイメージ
FROM ruby:3.2.3

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  nodejs \
  default-mysql-client \
  vim \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app

# Bundlerをインストール
RUN gem install bundler

# ★★★ ここに rails コマンドをインストールする行を追加します ★★★
# rails new を実行するために、rails gem 本体をグローバルにインストールする
RUN gem install rails

# ホストからGemfile, Gemfile.lockをコピー
# この時点ではまだファイルがない可能性が高いですが、後で上書きされます
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# gemのインストール (Gemfileの内容に基づく)
RUN bundle install

# タイムゾーン設定（コンテナ内で時間がずれないように）
ENV TZ Asia/Tokyo
