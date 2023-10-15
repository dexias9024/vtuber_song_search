class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.integer :cover, null: false
      t.string :name
      t.string :artist_name
      t.references :vtuber, null: false, foreign_key: true
      t.string :video_url, null: false

      t.timestamps
    end
    add_index :songs, [:title, :name, :artist_name]
  end
end
