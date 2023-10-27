class CreateInstruments < ActiveRecord::Migration[7.1]
  def change
    create_table :instruments do |t|

      t.string :name, null: false
    end
  end
end
