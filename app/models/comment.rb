class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :song

  validates :content, presence: true, length: { maximum: 5000 }

  def self.ransackable_associations(auth_object = nil)
    %w[song user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[content user_name song_title]
  end
end
