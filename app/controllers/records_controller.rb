class RecordsController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @records = Record.order(created_at: :desc).where("user_id = ?", @user.id)
  end
end
