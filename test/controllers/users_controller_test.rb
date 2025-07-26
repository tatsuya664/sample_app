require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user) # ログインせずに編集ページにアクセス
    assert_not flash.empty?   # flashメッセージが表示されるはず
    assert_redirected_to login_url # ログインページにリダイレクトされるはず
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } } # ログインせずに更新リクエストを送信
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user) # 別のユーザーとしてログイン
    get edit_user_path(@user)
    assert flash.empty? # flashメッセージは表示されない
    assert_redirected_to root_url # ルートURLにリダイレクトされる
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user) # 別のユーザーとしてログイン
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
