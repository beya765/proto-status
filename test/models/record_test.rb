require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  def setup
    @user   = users(:test_user)
    @record = @user.records.build(act_content: "テストアクション", grow_content: "成長")
  end

  test "Recordモデルの有効性" do
    assert @record.valid?
    @record.user_id = nil
    assert_not @record.valid?
  end

  test "Recordモデルのバリデーション(act_content)" do
    @record.act_content = "   "
    assert_not @record.valid?
  end

  test "Recordモデルのバリデーション(grow_content)" do
    @record.grow_content = "   "
    assert_not @record.valid?
  end

  test "Recordモデルの順序付け" do
    assert_equal records(:sample01), Record.first
  end
end
