class VtuberInstrument < ApplicationRecord
  belongs_to :vtuber
  belongs_to :instrument

  validates :vtuber_id, uniqueness: { scope: :instrument_id }
end
