# test/controllers/password_resets_controller_test.rb

require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # `password_resets_new_url` から `new_password_reset_path` に修正
    get new_password_reset_path
    assert_response :success
  end
end