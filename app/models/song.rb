class Song < ApplicationRecord
  belongs_to :vtuber
  has_many :comments, dependent: :destroy
  has_many :vtubers, through: :comments
  has_many :favorites, dependent: :destroy

  enum cover: { cover: 0, original: 1} 

  validates :title, presence: true
  validates :cover, presence: true
  validates :video_url, presence: true, uniqueness: true


  def youtube_id_from_url
    match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
    match_data[5] if match_data
  end

  def self.ransackable_associations(auth_object = nil)
    %w[vtuber]
  end

  def self.ransackable_attributes(auth_object = nil)
    super + %w[title name artist_name cover]
  end
end
