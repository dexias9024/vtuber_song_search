class CreateInquiries < ActiveRecord::Migration[7.1]
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :content, null: false
      t.datetime :created_at
      t.datetime :closed_at
    end
  end
end