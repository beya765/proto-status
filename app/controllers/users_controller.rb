class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @state = @user.build_state
    @record = @user.records.build(act_content: "最初の一歩", grow_content: "成長")
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

    if lvup(@state).nil?
      respond_to do |format|
        format.js { flash.now[:info] =  "更新すべきものはありませんでした"  }
      end
    else
      respond_to do |format|
        format.js { flash.now[:success] =  "ステータス更新！"  }
      end
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
      point = {str: params[:strP].to_i, vit: params[:vitP].to_i, dex: params[:dexP].to_i, int: params[:intP].to_i, spe: params[:speP].to_i}
      divisor = 3

      # 各ステータスの星が満たされていれば、レベルアップ
      max_attr = params[:max].split(',')
      state[:lv] += max_attr.length

      # 記録保存用
      jap_attr = {lv: "レベル", str: "ちから", vit: "たいりょく", dex: "きよう", int: "かしこさ", spe: "とくしゅ"}
      grow_str = ""

      point.each do |key, raty_point|
        if !max_attr.blank?
          max_attr.each do |attr_name|
            # 星1に3P振った場合
            if (state[key]%divisor == 1 && raty_point == 1 && key.to_s == attr_name)
              puts("# 星1に3P振った場合")
              state[:point] -= 3
              state[key] += 3
            # 星2に2P振った場合
            elsif (state[key]%divisor == 2 && raty_point == 1 && key.to_s == attr_name)
              puts("# 星2に2P振った場合")
              state[:point] -= 2
              state[key] += 2
            # 星2に3P振った場合
            elsif (state[key]%divisor == 2 && raty_point == 2 && key.to_s == attr_name)
              puts("# 星2に3P振った場合")
              state[:point] -= 3
              state[key] += 3
            else
              if key.to_s == attr_name
                state[:point] -= (raty_point - state[key]%divisor)
                state[key] += (raty_point - state[key]%divisor)
              end
            end
          end
        else
          if state[key]%divisor != raty_point
            state[:point] -= (raty_point - state[key]%divisor)
            state[key] += (raty_point - state[key]%divisor)
          end
        end 
      end

      # in_database 元: _was
      State.column_names.each do |attr|
        if state[attr] != state.send("#{attr}_in_database") && attr != "point"
          grow_str << "#{jap_attr[attr.to_sym]}が#{state[attr]-state.send("#{attr}_in_database")}上がった。"
        end
      end

      if state.has_changes_to_save?
        if state.save
          puts "save success"
          user = User.find(state.user_id)
          user.records.create(act_content: params[:state][:action], grow_content: grow_str)
        else
          puts "save fail"
          puts state.errors.full_messages
        end
      end
    end

end
