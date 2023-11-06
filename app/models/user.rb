class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :icon, IconUploader

  has_many :user_requests, dependent: :destroy
  has_many :user_favorites, dependent: :destroy
  has_many :songs, through: :user_favorites
  has_many :comments, dependent: :destroy
  has_many :songs, through: :comments

  enum role: { general: 0, admin: 1, guest: 2} 

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :role, presence: true
end
