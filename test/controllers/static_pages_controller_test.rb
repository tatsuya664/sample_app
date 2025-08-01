require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  # 'static_pages_home_url' は 'root_url' と同じなので削除またはコメントアウト
  # test "should get home" do
  #   get root_url
  #   assert_response :success
  #   assert_select "title", "Home | #{@base_title}"
  # end

  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
end