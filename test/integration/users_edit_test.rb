require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
  end

  test "無効な値でのユーザー情報更新" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "invalid@foo",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
  end

  test "有効な値でユーザー情報を更新" do
    get edit_user_path(@user)
    log_in_as(@user)
    name = "FooBar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user

    # DBから最新のユーザ情報を読み込んで、正しく更新されたか確認
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
