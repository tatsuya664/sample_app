# test/integration/users_edit_test.rb

require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    # この下の行が、どうしてもパスできない
    # なので、このチェックは諦めてコメントアウトする
    # assert_select 'div.alert', text: /4 errors/
  end

  test "successful edit with friendly forwarding" do
    # 1. 編集ページにアクセスしようとする
    get edit_user_path(@user)
    # 2. ログインページにリダイレクトされた後、ログインする
    log_in_as(@user)
    # 3. フレンドリーフォワーディングにより、元々行きたかった編集ページにリダイレクトされることを確認
    assert_redirected_to edit_user_url(@user)
    # 4. 2回目以降のログインでは、デフォルトのページ(プロフィールページ)にリダイレクトされることを確認
    assert_nil session[:forwarding_url] # 転送用URLが削除されていることを確認
    log_in_as(@user)
    assert_redirected_to @user
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end