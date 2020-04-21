require 'test_helper'

class HomeViewTest < ActionDispatch::IntegrationTest
  test "ホーム画面のテスト" do
    get root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", users_path
    assert true
  end
end
