require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  # 11章で追加: メールのdeliveries配列をクリアするsetupメソッド
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    # 登録ページにアクセスする
    get signup_path
    
    # User.count（ユーザー数）が変わらないことを確認しながら
    assert_no_difference 'User.count' do
      # わざと無効な情報をPOSTする
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    
    # 失敗したので、users/new（登録）ページが再描画されることを確認
    assert_template 'users/new'
    # 失敗したので、422 Unprocessable Entityが返されることを確認
    assert_response :unprocessable_entity
    # エラーメッセージが表示されているか確認
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  # 11章で変更: テストケースを有効化フローに合わせて全面的に書き換え
  test "valid signup information with account activation" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    assert_not is_logged_in?
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end