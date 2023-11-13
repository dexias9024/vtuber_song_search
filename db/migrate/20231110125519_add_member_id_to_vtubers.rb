class AddMemberIdToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_reference :vtubers, :member, null: false, foreign_key: true
  end
end
