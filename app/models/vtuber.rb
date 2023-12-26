class Vtuber < ApplicationRecord
  has_many :songs, dependent: :destroy
  belongs_to :member
  has_many :vtuber_instruments, dependent: :destroy
  has_many :instruments, through: :vtuber_instruments

  validates :channel_name, presence: true, uniqueness: true
  validates :channel_url, presence: true, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    %w[vtuber_instruments]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[channel_name name]
  end
end