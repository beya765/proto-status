class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update]
  before_action :correct_user,    only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user   = User.new(user_params)
    @state  = @user.build_state
    
    if @user.save && @state.save
      log_in @user
      flash[:success] = "『Avartus』へようこそ！"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render 'new' 
    end
  end

  def show
    @user  = User.find(params[:id])
    @state = @user.state
    @state.point_recovery
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) && !@user.saved_change_to_image?
      flash[:success] = "プロフィールの更新が完了しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    # strong parameters設定
    def user_params
      params.require(:user)
        .permit(:name, :email, :image, :password, :password_confirmation)
    end
end
