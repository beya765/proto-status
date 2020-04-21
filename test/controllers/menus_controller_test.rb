require 'test_helper'

class MenusControllerTest < ActionDispatch::IntegrationTest
  test "ホーム画面のテスト" do
    get root_path
    assert_response :success
  end

  test "アバウト画面のテスト" do
    get about_path
    assert_response :success
  end

end
