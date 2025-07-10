# Rubyの公式イメージをベースにする
FROM ruby:3.2.8

# 必要なシステムツール（ビルドツール、DBクライアント、Node.jsのインストーラー`curl`）をインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  postgresql-client \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Node.js 18.x を、NodeSourceの公式リポジトリからインストールする
# これにより、古くて問題のあるOS標準のnodejsではなく、最新で完全なnodejsがインストールされる
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