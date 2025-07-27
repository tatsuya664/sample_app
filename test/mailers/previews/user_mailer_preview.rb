# test/mailers/previews/user_mailer_preview.rb
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    # CHANGE START: account_activationと同様に、userを渡すように修正
    user = User.first
    # チュートリアル12章で追加する属性です
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
    # CHANGE END
  end

end