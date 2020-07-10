require 'test_helper'

class StatesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @state = states(:sample_state)
  end

  test "未ログインでStateデータを送信" do
    patch state_path(@state), params: { strP: @state.str }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
