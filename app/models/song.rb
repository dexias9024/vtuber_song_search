class Song < ApplicationRecord
  belongs_to :vtuber
  has_many :comments, dependent: :destroy
  has_many :vtubers, through: :comments
  has_many :user_favorites, dependent: :destroy
  has_many :users, through: :user_favorites

  enum cover: { cover: 0, original: 1} 

  validates :title, presence: true
  validates :cover, presence: true
  validates :video_url, presence: true, uniqueness: true

  def youtube_id_from_url
    match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
    match_data[5] if match_data
  end
end
