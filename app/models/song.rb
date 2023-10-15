class Song < ApplicationRecord
  belongs_to :vtuber
  has_many :comments, dependent: :destroy
  has_many :vtubers, through: :comments
  has_many :user_favorites, dependent: :destroy
  has_many :users, through: :user_favorites

  validates :title, presence: true
  validates :cover, presence: true
  validates :video_url, presence: true
end
