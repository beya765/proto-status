require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "サンプルユーザー", email: "samp@le.com",
                     password: "123456", password_confirmation: "123456")
  end

  test "ユーザーの有効性テスト" do
    assert @user.valid?
  end

  test "name属性のvalidateテスト" do
    @user.name = "    "
    assert_not @user.valid?
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email属性のvalidateテスト" do
    @user.email = "    "
    assert_not @user.valid?
    @user.email = "l" * 255 + "ong@email.com"
    assert_not @user.valid?

    invalid_addresses = %w[ user@example,com user_at_foo.org
                            user.name@example. foo@bar_baz.com
                            foo@bar+baz.com foo@bar..com ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end

  test "重複するメールアドレスは拒否される" do
    # @user.dupでデータの複製
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "メールアドレス小文字化に対するテスト" do
    mixed_case_email = "Big@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    # reloadメソッド = データベースの値に合わせて更新する
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "空白などのパスワードは有効にならない" do
    assert @user.authenticate("123456")
    # 多重代入。passwordとpasswordconfirmationに対して同時に代入
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
    # gakuさんに訊いてみる？　日本語コピペでパスワード入力できるけど・・・
    # @user.password = @user.password_confirmation = "あいうえおか"
    # assert_not @user.valid?
  end

  test "５文字以下のパスワードは有効にならない" do
    assert @user.authenticate("123456")
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
