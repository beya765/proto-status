class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @state = @user.build_state
    @record = @user.records.build(content: "最初の一歩")
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

    @record = Record.find(params[:user_id])

    respond_to do |format|
      # format.html { redirect_to @user }
      format.js
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

      # 記録保存用
      jap_attr = {lv: "レベル", str: "ちから", vit: "たいりょく", dex: "きよう", int: "かしこさ", spe: "とくしゅ"}
      growth_str = "成長："

      point = {str: params[:strP], vit: params[:vitP], dex: params[:dexP], int: params[:intP], spe: params[:speP]}
      # 各ステータスの星が満たされていれば、レベルアップ
      max = params[:max].split(',')
      state[:lv] += max.length
      
      point.each do |key, p|
        if !max.blank?
          max.each do |m|
            # 星1に3P振った場合
            if (state[key]%3 == 1 && p.to_i == 1 && key.to_s == m)
              puts("# 星1に3P振った場合")
              state[:point] -= 3
              state[key] += 3
            # 星2に2P振った場合
            elsif (state[key]%3 == 2 && p.to_i == 1 && key.to_s == m)
              puts("# 星2に2P振った場合")
              state[:point] -= 2
              state[key] += 2
            # 星2に3P振った場合
            elsif (state[key]%3 == 2 && p.to_i == 2 && key.to_s == m)
              puts("# 星2に3P振った場合")
              state[:point] -= 3
              state[key] += 3
            else
              if key.to_s == m
                state[:point] -= (p.to_i - state[key]%3)
                state[key] += (p.to_i - state[key]%3)
              end
            end
          end
        else
          if state[key]%3 != p.to_i
            state[:point] -= (p.to_i - state[key]%3)
            state[key] += (p.to_i - state[key]%3)
          end
        end 
      end

      # in_database 元: _was
      State.column_names.each do |attr|
        if state[attr] != state.send("#{attr}_in_database") && attr != "point"
          puts(state.send("#{attr}_in_database"))
          growth_str << "#{jap_attr[attr.to_sym]}が#{state[attr]-state.send("#{attr}_in_database")}上がった。"
        end
      end

      if state.has_changes_to_save?
        if state.save
          puts "save success"
          user = User.find(state.user_id)
          user.records.create(content: "行動：#{params[:state][:action]}\r\n#{growth_str}")
        else
          puts "save fail"
          puts state.errors.full_messages
        end
      end
    end

end
