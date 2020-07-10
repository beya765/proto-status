require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user   = users(:test_user)
    @other  = users(:other_user)
  end

  test "新規登録コントローラーのテスト" do
    get regist_path
    assert_response :success
  end

  test "未ログインでユーザー編集画面へアクセス" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "未ログインでユーザー情報をPATCH送信" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "他ユーザーで編集画面へアクセス" do
    log_in_as(@other)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "他ユーザーでユーザー情報をPATCH送信" do
    log_in_as(@other)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
