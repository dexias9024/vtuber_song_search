class Member < ApplicationRecord
  has_many :vtubers, dependent: :destroy
  
  validates :name, presence: true
end
