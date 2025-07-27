# app/mailers/user_mailer.rb

class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # CHANGE START: password_resetメソッドもuserを引数に取るように修正します
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  # CHANGE END

end