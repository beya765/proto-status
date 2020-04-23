require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "新規登録コントローラーのテスト" do
    get regist_path
    assert_response :success
  end

end
