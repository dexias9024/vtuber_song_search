class Member < ApplicationRecord
  has_many :vtubers, dependent: :destroy
  has_many :request_instruments, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
