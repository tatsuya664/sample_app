# ベースとなるRubyのイメージを指定
FROM ruby:3.2.8-slim-bullseye

# 必要なライブラリをインストール
# psych gemのビルドに必要なlibyaml-devを追加
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn libyaml-dev

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

# RAILS_MASTER_KEYは不要だが、secret_key_baseはビルド時に必要なのでダミーの値を渡す
RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile


# ポートを開放
EXPOSE 3000

# コンテナ起動時にWebサーバーを起動
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]