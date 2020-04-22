class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # user = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    # @user = User.new(user)

    if @user.save
      redirect_to root_url
    else
      render 'new' 
    end
  end
end
