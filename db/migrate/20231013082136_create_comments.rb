class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :song, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
