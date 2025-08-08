# Ruby on Rails Tutorial サンプルアプリケーション

これは、「Ruby on Railsチュートリアル」を参考に作成したサンプルアプリケーションです。
このアプリケーションは、Twitter（現X）のようなマイクロポスト投稿SNSのコア機能を実装しています。

## 主な機能

* ユーザー登録、ログイン、ログアウト機能 (セッション管理、Remember me機能を含む)
* アカウント有効化 (Action Mailerによるメール送信)
* パスワード再設定機能
* プロフィール表示・編集機能 (認可に基づいたアクセス制御)
* マイクロポストの投稿・削除機能 (画像アップロード対応)
* ユーザー間のフォロー・アンフォロー機能
* ステータスフィード (自分とフォローしているユーザーの投稿一覧)
* 管理者によるユーザー削除機能

## 使用技術

* **Ruby:** 3.2.8
* **Rails:** 7.0.8
* **データベース:** PostgreSQL
* **CSSフレームワーク:** Bootstrap 5
* **JavaScript:** Hotwire/Turbo, Importmap
* **テスト:** Minitest
* **開発環境:** Docker / docker-compose
* **デプロイ先:** Render

## セットアップ手順 (開発環境)

1.  このリポジトリをクローンします。
    
    git clone [https://github.com/](https://github.com/)[あなたのGitHubユーザー名]/sample_app.git
    
2.  ディレクトリを移動します。
    
    cd sample_app
    
3.  Dockerコンテナをビルドします。
    
    docker-compose build
    
4.  データベースを作成・設定します。
    
    docker-compose run --rm web rails db:create
    docker-compose run --rm web rails db:migrate
    
5.  サーバーを起動します。
    
    docker-compose up
    
6.  ブラウザで `http://localhost:3000` にアクセスします。