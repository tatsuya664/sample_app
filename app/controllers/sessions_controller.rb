class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 11章で変更: user.activated? のチェックを追加します
      if user.activated?
        # 1. 記憶していたURLを変数に保存する
        forwarding_url = session[:forwarding_url]
        # 2. セッションをリセットする
        reset_session
        # 3. ログインして、"Remember me"を処理する
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # 4. 記憶したURL、もしくはデフォルトのURLにリダイレクトする
        redirect_to forwarding_url || user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
      # ここまで11章の変更
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
