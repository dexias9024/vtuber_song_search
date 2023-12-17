class RequestInstrument < ApplicationRecord
  belongs_to :request
  belongs_to :instrument

  validates :request_id, uniqueness: { scope: :instrument_id }
end
