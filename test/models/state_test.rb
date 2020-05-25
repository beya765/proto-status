require 'test_helper'

class StateTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @state = @user.build_state
  end
  
  test "Stateモデルの有効性テスト" do
    assert @state.valid?
    @state.user_id = nil
    assert_not @state.valid?
  end

  test "レベルやステータスは数値のみ" do
    @state.lv = '１０'
    assert_not @state.valid?
  end

  test "レベルやステータスの最大値は99" do
    @state.lv = 100
    assert_not @state.valid?
  end
end
