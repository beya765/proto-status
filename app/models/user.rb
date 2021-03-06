class User < ApplicationRecord
  has_one  :state,   dependent: :destroy, class_name: :State
  has_many :records, dependent: :destroy

  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 30 }
  # email正規化
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password
  # CarrierWaveに画像と関連付けたUserモデルを伝える
  mount_uploader :image, ImageUploader

  # 渡された文字列のハッシュ値を返す
  # https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    email.downcase!
  end
end
