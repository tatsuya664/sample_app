#!/bin/bash
set -e

# データベースのマイグレーションを実行
bundle exec rails db:migrate

# Pumaサーバーを起動
bundle exec puma -C config/puma.rb