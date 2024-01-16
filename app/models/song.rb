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

  scope :search_by_title_name_artist, ->(key_words) {
    conditions = key_words.map { |word| "(title ILIKE ? OR name ILIKE ? OR artist_name ILIKE ?)" }.join(' AND ')
    where(conditions, *Array.new(key_words.size * 3) { |i| "%#{key_words[i / 3]}%" })
  }

  scope :search_by_name, ->(key_words) {
    where("LOWER(name) LIKE :q", q: "#{key_words.downcase}%")
  }

  scope :search_by_artist, ->(key_words) {
    where("LOWER(artist_name) LIKE :q", q: "#{key_words.downcase}%")
  }

  scope :search_by_cover, ->(cover) {
    where(cover: cover)
  }
end
