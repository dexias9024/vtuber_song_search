class UserFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :song

  validates :user_id, uniqueness: { scope: :song_id }
end
