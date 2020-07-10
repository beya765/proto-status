class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      # store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    # ユーザーが異なる場合、ホーム画面へ(current_user?はセッションヘルパーメソッド)
    redirect_to(root_url) unless current_user?(@user)
  end
end
