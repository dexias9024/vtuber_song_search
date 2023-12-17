class Member < ApplicationRecord
  has_many :vtubers, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  def update_vtubers
    oldest_member_id = Member.order(:id).first&.id

    Vtuber.where(member_id: id).update_all(member_id: oldest_member_id)
  end

  def oldest_member?
    self.id == Member.order(:id).first&.id
  end
end
