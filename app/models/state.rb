class State < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :lv, numericality: { less_than: 100 }
  validates :str, numericality: { less_than: 100 }
  validates :int, numericality: { less_than: 100 }
end
