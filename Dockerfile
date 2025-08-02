# Rubyの公式イメージをベースにする
FROM ruby:3.2.8

# 必要なシステムツールを一度にインストールする
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  postgresql-client \
  curl \
  libvips-dev \
  && rm -rf /var/lib/apt/lists/*

# Node.jsとyarnをインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs
RUN corepack enable

# 作業ディレクトリを設定
WORKDIR /app

# Gemfileとpackage.jsonを先にコピーして、ライブラリのインストールをキャッシュする
COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install
RUN yarn install

# アプリケーションのソースコード全体をコピー
COPY . .

# --- ↓↓↓ ここからが追記・修正箇所です ↓↓↓ ---
# 本番環境用にアセットをビルドする
# SECRET_KEY_BASE_DUMMYは、アセットビルド時にキーがなくてもエラーにならないためのおまじない
RUN SECRET_KEY_BASE_DUMMY=1 yarn build:css
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile
# --- ↑↑↑ ここまでが追記・修正箇所です ↑↑↑ ---

# サーバーを起動するコマンド
CMD ["bundle", "exec", "rails", "server"]