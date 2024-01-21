class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :icon, IconUploader

  has_many :requests, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :songs, through: :favorites
  has_many :comments, dependent: :destroy
  has_many :songs, through: :comments

  enum role: { general: 0, admin: 1, guest: 2} 

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :role, presence: true
  validates :profile, length: { maximum: 500 }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def own?(object)
    id == object.user_id
  end

  def favorited?(song)
    favorites.exists?(song: song)
  end

  scope :search_by_name, ->(key_words) {
    where("lower(name) LIKE ?", "#{key_words.downcase}%")
  }
end
