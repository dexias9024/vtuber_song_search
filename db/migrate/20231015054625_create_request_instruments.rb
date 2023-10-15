class CreateRequestInstruments < ActiveRecord::Migration[7.1]
  def change
    create_table :request_instruments do |t|
      t.references :user_request, null: false, foreign_key: true
      t.references :instrument, null: false, foreign_key: true
    end
    add_index :request_instruments, [:user_request_id, :instrument_id], unique: true
  end
end
