require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  test "未ログインで成長記録メニューへアクセス" do
    get record_path
    assert_redirected_to login_url
  end
end
