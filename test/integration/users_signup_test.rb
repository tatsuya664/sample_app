require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

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

  test "valid signup information" do
    # 登録ページにアクセスする
    get signup_path
    
    # User.countが1増えることを確認しながら
    assert_difference 'User.count', 1 do
      # 有効な情報をPOSTする
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    
    # 成功したので、リダイレクト先にちゃんと従う
    follow_redirect!
    # 成功したので、users/showページが表示されることを確認
    assert_template 'users/show'
    # 成功したので、flashメッセージが表示されていることを確認
    assert_not flash.empty?
    # ログイン状態になっていることを確認（第8章で実装）
    # is_logged_in?
  end
end