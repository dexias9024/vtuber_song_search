class CreateVtubers < ActiveRecord::Migration[7.1]
  def change
    create_table :vtubers do |t|
      t.string :channel_name, null: false
      t.string :channel_url, null: false
      t.string :name
      t.string :icon
      t.references :instrument, foreign_key: true
      t.text :overview

      t.timestamps
    end
    add_index :vtubers, [:channel_name, :name]
  end
end
