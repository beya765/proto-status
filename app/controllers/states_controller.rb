class StatesController < ApplicationController
  before_action :logged_in_user,  only: :update
  before_action :correct_user,    only: :update

  def update
    @state = State.find_by(user_id: params[:id])

    if lvup(@state).nil?
      respond_to do |format|
        format.js { flash.now[:info] = "更新すべきものはありませんでした" }
      end
    else
      respond_to do |format|
        format.js { flash.now[:success] = "ステータス更新！" }
      end
    end
  end

  private

  # ステータスの更新
  def lvup(state)
    point     = { str: params[:strP].to_i, vit: params[:vitP].to_i, dex: params[:dexP].to_i,
                  int: params[:intP].to_i, spe: params[:speP].to_i }
    divisor   = 3
    raty_max  = 3

    # 各ratyのスコアが満たされた分だけレベルアップ
    full_attr   = params[:full_attr].split(',')
    state[:lv] += full_attr.length

    # 記録保存用
    jap_attr = { lv: "レベル", str: "ちから", vit: "たいりょく", dex: "きよう", int: "かしこさ", spe: "とくしゅ" }
    grow_str = ""

    # 各ratyにて、スコアを満たしていた場合
    if full_attr.present?
      full_attr.each do |attr_name|
        if point[attr_name.to_sym] == raty_max
          state[:point]     -= raty_max - state[attr_name] % divisor
          state[attr_name]  += raty_max - state[attr_name] % divisor
        else
          state[:point]     -= raty_max - state[attr_name] % divisor + point[attr_name.to_sym]
          state[attr_name]  += raty_max - state[attr_name] % divisor + point[attr_name.to_sym]
        end
      end
    end

    # 各ratyにて、スコアを満たしていないがポイントが振られた場合
    point.each do |key, raty_point|
      unless state.send("will_save_change_to_#{key}?")
        if state[key] % divisor != raty_point
          state[:point] -= (raty_point - state[key] % divisor)
          state[key]    += (raty_point - state[key] % divisor)
        end
      end
    end

    # 各ステータスの変化値を計算し、成長記録を作成
    State.column_names.each do |attr|
      if state[attr] != state.send("#{attr}_in_database") && attr != "point"
        grow_str << "#{jap_attr[attr.to_sym]}が#{state[attr] - state.send("#{attr}_in_database")}上がった。"
      end
    end

    # ステータスに変化があれば、成長記録と共に保存
    if state.has_changes_to_save?
      if state.save
        user = User.find(state.user_id)
        user.records.create(act_content: params[:state][:action], grow_content: grow_str)
      else
        logger.debug("ステートパラメータ保存失敗！！")
        logger.debug(state.errors.full_messages)
      end
    end
  end
end
