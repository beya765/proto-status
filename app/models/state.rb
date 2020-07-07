class State < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :lv,  numericality: { less_than: 100 }
  validates :str, numericality: { less_than: 100 }
  validates :vit, numericality: { less_than: 100 }
  validates :dex, numericality: { less_than: 100 }
  validates :int, numericality: { less_than: 100 }
  validates :spe, numericality: { less_than: 100 }

  def point_recovery
    # if Date.today > updated_at.ago(1.days)
    if Date.today > updated_at
      update_attribute(:point, 30)
    end
  end
end
