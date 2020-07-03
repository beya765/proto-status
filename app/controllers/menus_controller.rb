class MenusController < ApplicationController
  def home
  end

  def about
    @rand_state = State.new

    # デモ表示用のステータスパラメータ
    State.column_names.each do |attr|
      if @rand_state[attr].class == Integer
        @rand_state[attr] = rand(100)
      end
    end
  end

end
