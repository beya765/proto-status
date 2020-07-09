require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
  end

  test "ユーザー画面" do
    get user_path(@user)
    assert_template 'users/show'
    # assert_select 'a[href=?]', edit_user_path(@user), count: 2
    # assert_select 'ul>li>h1',  text: @user.name
    # assert_select 'ul>li>span',  text: @user.state.point
  end

end