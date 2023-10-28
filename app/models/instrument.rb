class Instrument < ApplicationRecord
  has_many :vtuber_instruments, dependent: :destroy
  has_many :vtubers, through: :vtuber_instruments
  has_many :request_instruments, dependent: :destroy
  has_many :user_requests, through: :request_instruments

  validates :name, presence: true
end