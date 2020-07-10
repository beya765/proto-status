require 'test_helper'

class MenusControllerTest < ActionDispatch::IntegrationTest
  test "ホームコントローラーのテスト" do
    get root_path
    assert_response :success
  end

  test "アバウトコントローラーのテスト" do
    get about_path
    assert_response :success
  end
end
