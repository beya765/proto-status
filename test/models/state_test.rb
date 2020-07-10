require 'test_helper'

class StateTest < ActiveSupport::TestCase
  max_over = 999

  def setup
    @user   = users(:test_user)
    @state  = states(:sample_state)
  end

  test "Stateモデルの有効性テスト" do
    assert @state.valid?
    @state.user_id = nil
    assert_not @state.valid?
  end

  test "各ステータスは数値のみ(lv: 上限100)" do
    @state.lv = '１０'
    assert_not @state.valid?
    @state.lv = max_over
    assert_not @state.valid?
  end

  test "各ステータスは数値のみ(str: 上限100)" do
    @state.str = '１０'
    assert_not @state.valid?
    @state.str = max_over
    assert_not @state.valid?
  end

  test "各ステータスは数値のみ(vit: 上限100)" do
    @state.vit = '１０'
    assert_not @state.valid?
    @state.vit = max_over
    assert_not @state.valid?
  end

  test "各ステータスは数値のみ(dex: 上限100)" do
    @state.dex = '１０'
    assert_not @state.valid?
    @state.dex = max_over
    assert_not @state.valid?
  end

  test "各ステータスは数値のみ(int: 上限100)" do
    @state.int = '１０'
    assert_not @state.valid?
    @state.int = max_over
    assert_not @state.valid?
  end

  test "各ステータスは数値のみ(spe: 上限100)" do
    @state.spe = '１０'
    assert_not @state.valid?
    @state.spe = max_over
    assert_not @state.valid?
  end

  test "ポイントは数値のみ(point)" do
    @state.point = '１０'
    assert_not @state.valid?
  end

  # test "レベルやステータスは数値のみ" do
  #   State.column_names.each do |attr|
  #     @state[attr] = '１０' if @state[attr].class == Integer
  #   end
  # end
end
