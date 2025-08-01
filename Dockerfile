# Dockerfile (最終修正版)

# Rubyの公式イメージをベースにする
FROM ruby:3.2.8

# 必要なシステムツールを一度にインストールする
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  postgresql-client \
  curl \
  #  画像リサイズ用のライブラリlibvips-devをここに追加します
  libvips-dev \
  && rm -rf /var/lib/apt/lists/*

# Node.js 18.x を、NodeSourceの公式リポジトリからインストールする
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs

# Node.jsに含まれる`corepack`を使って、`yarn`を有効化する
RUN corepack enable

# 作業ディレクトリを設定
WORKDIR /app

# Gemfileを先にコピーして、Gemのインストールをキャッシュする
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのソースコード全体をコピー
COPY . .

# RailsサーバーとCSS/JSビルダーを同時に起動する開発用コマンド
CMD ["bin/dev"]