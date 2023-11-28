class CreateRequestInstruments < ActiveRecord::Migration[7.1]
  def change
    create_table :request_instruments do |t|
      t.references :request, null: false, foreign_key: true
      t.references :instrument, null: false, foreign_key: true

      t.timestamps
    end
    add_index :request_instruments, [:request_id, :instrument_id], unique: true
  end
end