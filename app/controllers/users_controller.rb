class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @state = @user.build_state
    if @user.save
      log_in @user
      flash[:success] = "あなたの『すていたす』へようこそ！"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render 'new' 
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @state = @user.state
  end

  def update
    @state = State.find(params[:user_id])
    lvup(@state)
    @state.reload
    
    respond_to do |format|
      # format.html { redirect_to @user }
      format.js { flash.now[:success] = "ステータスの更新完了！" }
    end
  end

  private
    # strong parameters設定
    def user_params
      params.require(:user)
        .permit(:name, :email, :password, :password_confirmation)
    end

    # ステータスの更新
    def lvup(state)
      point = {str: params[:strP], int: params[:intP]}
      # 各ステータスの星が満たされていれば、レベルアップ
      max = params[:max].split(',')
      state[:lv] += max.length

      point.each do |key, p|
        if !max.blank?
          max.each do |m|
            # 星1に3P振った場合
            if (state[key]%3 == 1 && p.to_i == 1 && key.to_s == m)
              state[key] += 3
              puts("# 星1に3P振った場合")
            # 星2に2P振った場合
            elsif (state[key]%3 == 2 && p.to_i == 1 && key.to_s == m)
              state[key] += 2
              puts("# 星2に2P振った場合")
            # 星2に3P振った場合
            elsif (state[key]%3 == 2 && p.to_i == 2 && key.to_s == m)
              state[key] += 3
              puts("# 星2に3P振った場合")
            else
              puts(key,state[key],p.to_i)
              state[key] += (p.to_i - state[key]%3)
            end
          end
        else
          if state[key]%3 != p.to_i
            state[key] += (p.to_i - state[key]%3)
          end
        end 
      end

      if state.save
        puts "save success"
      else
        puts "save fail"
        puts state.errors.full_messages
      end
    end
end
