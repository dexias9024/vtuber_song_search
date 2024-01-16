class Instrument < ApplicationRecord
  has_many :vtuber_instruments, dependent: :destroy
  has_many :vtubers, through: :vtuber_instruments
  has_many :request_instruments, dependent: :destroy
  has_many :requests, through: :request_instruments

  validates :name, presence: true, uniqueness: true
end
