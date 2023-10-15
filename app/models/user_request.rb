class UserRequest < ApplicationRecord
  belongs_to :user
  has_many :request_instruments, dependent: :destroy
  has_many :instruments, through: :request_instruments

  validates :channnel_status, presence: true
  validates :name, presence: true
  validates :url, presence: true
end
