class Record < ApplicationRecord
  belongs_to :user
  validates :user_id,      presence: true # L13.5 ????
  validates :act_content,  presence: true
  validates :grow_content, presence: true
  default_scope -> { order(created_at: :desc) }
end
