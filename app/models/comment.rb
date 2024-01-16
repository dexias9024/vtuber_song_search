class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :song

  validates :content, presence: true, length: { maximum: 5000 }

  scope :search_comments, ->(key_words) {
    where("content ILIKE :q", q: "#{key_words.downcase}%")
  }
end
