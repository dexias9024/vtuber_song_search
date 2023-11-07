class Vtuber < ApplicationRecord
  mount_uploader :icon, IconUploader
  
  has_many :songs, dependent: :destroy
  belongs_to :member
  has_many :vtuber_instruments, dependent: :destroy
  has_many :instruments, through: :vtuber_instruments

  validates :channel_name, presence: true
  validates :channel_url, presence: true
end
