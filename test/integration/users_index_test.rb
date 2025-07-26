require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'nav.pagy-bootstrap-nav', count: 2

    # ★★★ ここからが修正箇所です ★★★
    # 削除リンクが一意に定まるように、'data-turbo-method'属性もセレクタに含めます
    assert_select 'a[data-turbo-method="delete"][href=?]', user_path(@non_admin), text: 'delete'

    # ユーザー削除が正しく機能することをテストします
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    # 'delete'というテキストを持つリンクが存在しないことを確認
    assert_select 'a[text=?]', 'delete', count: 0
  end
end