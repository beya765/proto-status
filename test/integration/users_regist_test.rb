require 'test_helper'

class UsersRegistTest < ActionDispatch::IntegrationTest

  test "無効なユーザー登録に対するテスト" do
    get regist_path

    # User.countでDBの登録件数が変わってないことを確認
    assert_no_difference 'User.count' do
      post regist_path, params: { user: { name: "",
                                        email: "user@invalid",
                                        password: "not",
                                        password_confirmation: "val" } }
    end
    assert_template 'users/new'

    # L7.25: エラーメッセージのテスト
    # assert_select 'div#error_explanation'
    # assert_select 'div.alert'

    assert_select 'form[action="/regist"]'
  end

  test "有効なユーザー登録に対するテスト" do
    get regist_path
    # 第2引数の1でDB登録の数が増えたことを確認
    assert_difference 'User.count', 1 do
      # L11.33: signup_path を users_path へ
      post regist_path, params: { user: { name: "Example User",
                                          email: "user@example.com",
                                          password: "password",
                                          password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
