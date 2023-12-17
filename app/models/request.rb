class Request < ApplicationRecord
  belongs_to :user
  has_many :request_instruments, dependent: :destroy
  has_many :instruments, through: :request_instruments

  enum category: { 'Vtuber': 0, '歌': 1 } 

  validates :category, presence: true
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
end
