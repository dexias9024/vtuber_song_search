class CreateVtuberInstruments < ActiveRecord::Migration[7.1]
  def change
    create_table :vtuber_instruments do |t|
      t.references :vtuber, null: false, foreign_key: true
      t.references :instrument, null: false, foreign_key: true
    end
    add_index :vtuber_instruments, [:vtuber_id, :instrument_id], unique: true
  end
end
