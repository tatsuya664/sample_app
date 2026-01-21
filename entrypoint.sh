#!/bin/bash
set -e

# データベースのマイグレーションを実行(2026/0122廃止)
# bundle exec rails db:migrate

# Pumaサーバーを起動
bundle exec puma -C config/puma.rb