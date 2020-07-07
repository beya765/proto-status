class Record < ApplicationRecord
  belongs_to :user
  validates :act_content,  presence: true
  validates :grow_content, presence: true
end
