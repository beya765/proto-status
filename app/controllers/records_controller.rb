class RecordsController < ApplicationController
  before_action :logged_in_user,  only: :show

  def show
    @user    = User.find(current_user.id)
    @records = Record.where("user_id = ?", @user.id).page(params[:page]).per(10)
  end
end
