# チュートリアルと同じ Ruby バージョン
FROM ruby:3.2.8

# Node.js と Yarn と PostgreSQL クライアントをインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn postgresql-client

# logger を明示的にインストール（Rails7+Ruby3.2で必須）
RUN gem install logger

# rails コマンドが logger を必ず require するように環境変数を設定
ENV RUBYOPT="--disable-gems -rlogger"

# 作業ディレクトリを設定
WORKDIR /app

# ホスト側の Gemfile をコピー
COPY Gemfile Gemfile.lock ./

# bundler で gem をインストール
RUN bundle install

# アプリケーションのソースをコピー
COPY . .

# 3000番ポートを開放
EXPOSE 3000

# デフォルトのコマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
