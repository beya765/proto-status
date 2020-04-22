class User < ApplicationRecord
  # validates :name, presence: true, length: { maximum: 30 }
  # validates :email, presence: true, length: { maximum: 50}
  has_secure_password
end
