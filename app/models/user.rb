class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :requests, dependent: :destroy
  has_many :user_favorites, dependent: :destroy
  has_many :songs, through: :user_favorites
  has_many :comments, dependent: :destroy
  has_many :songs, through: :comments

  enum role: { general: 0, admin: 1} 

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :role, presence: true
end
