class CreateUserRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :user_requests do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :channnel_status, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.string :member_name
    end
    add_index :user_requests, :url, unique: true
    add_index :user_requests, :name
  end
end
