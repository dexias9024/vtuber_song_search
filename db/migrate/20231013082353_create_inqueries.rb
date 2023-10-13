class CreateInqueries < ActiveRecord::Migration[7.1]
  def change
    create_table :inqueries do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :content, null: false
      t.datetime :created_at
      t.datetime :closed_at
    end
  end
end
