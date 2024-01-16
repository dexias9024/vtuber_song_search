class Vtuber < ApplicationRecord
  has_many :songs, dependent: :destroy
  belongs_to :member
  has_many :vtuber_instruments, dependent: :destroy
  has_many :instruments, through: :vtuber_instruments

  validates :channel_name, presence: true, uniqueness: true
  validates :channel_url, presence: true, uniqueness: true

  scope :search_by_name_channel_name, ->(key_words) {
    conditions = key_words.map { |word| "(channel_name ILIKE ? OR name ILIKE ?)" }.join(' AND ')
    where(conditions, *Array.new(key_words.size * 2) { |i| "%#{key_words[i / 2]}%" })
  }
end