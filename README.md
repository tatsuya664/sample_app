## ⚠️ 【重要】閲覧時のご注意 (Important Notice)

本アプリケーションは、クラウドサービス（Render）およびメールサービス（Mailgun）の**無料プラン**を利用して運用されています。
そのため、以下の制約により一時的に利用できない場合がございます。

### 1. 初回アクセスの遅延について
本アプリケーションはRenderの無料プランを使用しているため、一定期間アクセスがないとサーバーがスリープします。
スリープからの復帰（再起動）に**約1分ほど時間がかかる**場合がありますが、2回目以降の遷移はスムーズに行われます。

### 2. 画像の保存について
画像の保存先(Active Storage)をローカルディスクに設定しているため、**サーバーが再起動（デプロイやスリープ復帰）すると、投稿された画像は消去されます**。
（データベース上の文字データはSupabaseに保存されているため消えません）

### 3. アカウント登録メールが届かない場合があります
メール送信サービス（Mailgun）の仕様（Sandbox Mode）により、**事前に許可リスト（Authorized Recipients）に登録されたメールアドレス以外にはメールが送信されません**。
そのため、新規登録を行っても有効化メールが届かず、ログインできない場合がございます。
また、事前に登録されたアカウント(`sample.app664@gmail.com`など)であっても、メール送信サービス（Mailgun）の仕様により、一定期間利用がないとアカウントが一時停止され、**メール送信機能（新規登録時の有効化メールなど）が動作しなくなる**場合がございます。

### 🆘 アクセスできない場合のお問い合わせ
もし上記のような事象によりアプリケーションが正常に動作していない場合は、お手数ですが下記までご連絡いただけますと幸いです。
直ちに環境を復旧いたします。

* **Contact**: `sample.app664@gmail.com`

---

# Ruby on Rails Tutorial Sample App

「[Ruby on Rails チュートリアル](https://railstutorial.jp/)」を参考に作成した、Twitter（現X）ライクなSNSアプリケーションです。
マイクロポストの投稿、ユーザーフォロー、フィード機能など、SNSのコア機能を網羅的に実装しています。

## 📖 概要 (Overview)

このアプリケーションは、RailsによるWebアプリケーション開発の学習成果として作成されました。
ユーザー認証からデプロイまで、モダンなRails開発フロー（Docker, Hotwire, Cloud Deployment）を取り入れています。

**製作期間**: 約1ヶ月

## 🌐 アプリケーションへのアクセス (Access)

以下のURLから実際のアプリケーションを利用できます。

**[https://sample-app-muk1.onrender.com](https://sample-app-muk1.onrender.com)**

### 🔰 動作確認用アカウント (Test Account)
誰でも動作出来るように、以下のテスト用アカウントをご用意しております。
新規登録の手間なく、ログインして機能をご確認いただけます。

* **Email**: `sample.app664@gmail.com`
* **Password**: `password`

---

## ✨ 主な機能 (Features)

### ユーザー認証・管理
* **基本機能**: ユーザー登録、ログイン、ログアウト
* **セッション管理**: 「ログインしたままにする」機能（Remember me）
* **アカウント有効化**: メールによる本人確認プロセス（Action Mailer + Mailgun）
* **パスワード再設定**: 忘れたパスワードのリセット機能
* **管理者権限**: 管理者によるユーザー削除機能

### SNS機能
* **マイクロポスト**:
    * テキスト投稿および画像のアップロード（リサイズ機能付き）
    * 投稿の削除
* **ソーシャル**:
    * ユーザーのフォロー・アンフォロー
    * フォロー/フォロワー一覧ページ
* **フィード**: 自分とフォロー中のユーザーの投稿が流れるタイムライン
* **プロフィール**: 各ユーザーの投稿一覧と統計情報の表示

### 技術的特徴
* **セキュリティ**: BCryptによるパスワードハッシュ化、CSRF対策、認可制御
* **フロントエンド**: Hotwire (Turbo/Stimulus) によるSPA風の高速な画面遷移
* **デザイン**: Bootstrap 5 によるレスポンシブデザイン

## 🛠 使用技術 (Tech Stack)

| Category | Technology | Version |
| --- | --- | --- |
| **Language** | Ruby | 3.2.8 |
| **Framework** | Ruby on Rails | 7.0.8 |
| **Database** | Supabase (PostgreSQL) | - |
| **Frontend** | Hotwire (Turbo, Stimulus)<br>Bootstrap<br>Sass / CSS Bundling | 5.3 |
| **Infrastructure** | Docker / Docker Compose<br>Render (PaaS) | - |
| **Mail Service** | Mailgun (SMTP) | - |
| **Image Processing** | libvips / ImageProcessing | - |