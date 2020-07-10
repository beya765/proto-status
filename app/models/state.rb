class State < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :lv,    numericality: { less_than: 100 }
  validates :str,   numericality: { less_than: 100 }
  validates :vit,   numericality: { less_than: 100 }
  validates :dex,   numericality: { less_than: 100 }
  validates :int,   numericality: { less_than: 100 }
  validates :spe,   numericality: { less_than: 100 }
  validates :point, numericality: true

  def point_recovery
    # 最終更新時の翌日にポイント回復
    update(point: 30) if Time.zone.today > updated_at
  end
end
