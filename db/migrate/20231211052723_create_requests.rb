class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.integer :category, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.string :member_name
      t.references :instrument, foreign_key: true

      t.timestamps
    end
    add_index :requests, :url, unique: true
    add_index :requests, :name
  end
end