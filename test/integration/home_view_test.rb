require 'test_helper'

class HomeViewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
  end

  test "ホーム画面のリンク先確認（未ログイン）" do
    get root_path
    assert_template "menus/home"
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", about_path
  end

  test "ホーム画面のリンク先確認（ログイン済）" do
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", record_path
    assert_select "a[href=?]", edit_user_path(@user)    
    assert_select "a[href=?]", logout_path
  end
end
