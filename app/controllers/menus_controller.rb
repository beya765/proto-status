class MenusController < ApplicationController
  def home; end

  def about
    @rand_state = State.new

    # デモ表示用のステータスパラメータ
    State.column_names.each do |attr|
      @rand_state[attr] = rand(100) if @rand_state[attr].class == Integer
    end
  end
end
