# ローカル環境のRubyバージョンと一致させます
FROM ruby:3.2.8-slim-bullseye

# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# 作業ディレクトリを設定
WORKDIR /rails

# Gemfileを先にコピーしてgemのインストールをキャッシュ
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# アプリケーションコードをコピー
COPY . .

# 本番環境用の設定
ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

# アセットのプリコンパイルを実行
# precompile時にmaster.keyがなくてもエラーにならないようにするためのおまじない
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# ポートを開放
EXPOSE 3000

# コンテナ起動時にWebサーバーを起動
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]