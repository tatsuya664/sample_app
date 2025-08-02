# config/initializers/assets.rb

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# yarnでビルドされたCSSの置き場所(app/assets/builds)をアセットパイプラインの探索パスに追加します。
# これにより、Sprocketsがapplication.cssを見つけられるようになります。
Rails.application.config.assets.paths << Rails.root.join("app/assets/builds")