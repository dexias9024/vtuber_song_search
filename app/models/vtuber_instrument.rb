class VtuberInstrument < ApplicationRecord
  belongs_to :vtuber
  belongs_to :instrument

  validates :vtuber_id, uniqueness: { scope: :instrument_id }

  def self.ransackable_associations(auth_object = nil)
    %w[vtuber instrument]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[instrument_name]
  end
end
