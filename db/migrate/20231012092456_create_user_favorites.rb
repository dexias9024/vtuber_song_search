class CreateUserFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :user_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true
    end
    add_index :user_favorites, [:user_id, :song_id], unique: true
  end
end
