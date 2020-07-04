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
      raty_max = 3

      # 各ステータスの星が満たされていれば、レベルアップ
      full_attr = params[:full_attr].split(',')
      state[:lv] += full_attr.length

      # 記録保存用
      jap_attr = {lv: "レベル", str: "ちから", vit: "たいりょく", dex: "きよう", int: "かしこさ", spe: "とくしゅ"}
      grow_str = ""

      if !full_attr.blank?
        full_attr.each do |attr_name|
          if point[attr_name.to_sym] == raty_max
            state[attr_name]  += raty_max - state[attr_name]%divisor
            state[:point]     -= raty_max - state[attr_name]%divisor
          else
            state[attr_name]  += raty_max - state[attr_name]%divisor + point[attr_name.to_sym]
            state[:point]     -= raty_max - state[attr_name]%divisor + point[attr_name.to_sym]
          end
        end
      end

      point.each do |key, raty_point|
        if !state.send("will_save_change_to_#{key}?")
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
