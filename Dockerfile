# Dockerfile (最終修正版)

# Rubyの公式イメージをベースにする
FROM ruby:3.2.8

# 必要なシステムツールを一度にインストールする
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  postgresql-client \
  curl \
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

# --- ↓↓↓ ここからが追記・修正箇所です ↓↓↓ ---
# package.jsonとyarn.lockを先にコピーして、yarn installをキャッシュする
COPY package.json yarn.lock ./
# yarn installを実行して、sassなどのJSライブラリをインストールする
RUN yarn install
# --- ↑↑↑ ここまでが追記・修正箇所です ↑↑↑ ---

# アプリケーションのソースコード全体をコピー
COPY . .

# RailsサーバーとCSS/JSビルダーを同時に起動する開発用コマンド
# Renderのスタートコマンドで上書きされるため、本番環境では使われない
CMD ["bin/dev"]