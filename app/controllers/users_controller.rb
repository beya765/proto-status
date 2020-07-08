class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user   = User.new(user_params)
    @state  = @user.build_state
    @record = @user.records.build(act_content: "最初の一歩", grow_content: "成長")
    if @user.save
      log_in @user
      flash[:success] = "『Avartus』へようこそ！"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render 'new' 
    end
  end

  def show
    @user  = User.find_by(id: params[:id])
    @state = @user.state
    @state.point_recovery
  end

  def edit
    @user = User.find(params[:id])
    puts(@user.name)
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
