class RequestInstrument < ApplicationRecord
  belongs_to :user_request
  belongs_to :instrument

  validates :user_request_id, uniqueness: { scope: :instrument_id }
end
