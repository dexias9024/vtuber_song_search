class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :crypto_password, null: false
      t.string :email, null: false
      t.string :icon
      t.text :profile
      t.integer :role, default: 0, limit: 1, null: false

      t.timestamps
    end
    add_index :users, :role
    add_index :users, :email, unique: true
  end
end
