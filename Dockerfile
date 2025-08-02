# ベースとなるRubyのイメージを指定
FROM ruby:3.2.8-slim-bullseye

# ★★★★★ ここから修正 ★★★★★
# 必要なライブラリと、Node.js公式インストーラーを追加
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libyaml-dev \
  curl \
  gnupg \
  && curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y nodejs
# ★★★★★ ここまで修正 ★★★★★

# npmを使ってyarnをグローバルにインストール
RUN npm install -g yarn

# 作業ディレクトリを設定
WORKDIR /rails

# Gemfileを先にコピーしてgemのインストールをキャッシュ
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# package.jsonをコピーして、yarnでJSのパッケージをインストール
COPY package.json yarn.lock ./
RUN yarn install

# アプリケーションコードをコピー
COPY . .

# 本番環境用の設定
ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

# アセットのプリコンパイルを実行
RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

# Pumaのpidファイルを保存するディレクトリを作成
RUN mkdir -p tmp/pids

# ポートを開放
EXPOSE 3000

# コンテナ起動時にWebサーバーを起動
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]