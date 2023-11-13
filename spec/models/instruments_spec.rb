require 'rails_helper'

RSpec.describe 'Instrument', type: :model do
  context "Instrumentを作ることができる" do
    it "1-1.nameがある場合、有効である" do
      instrument = FactoryBot.build(:instrument)
      expect(instrument).to be_valid
    end
    
    it '1-2.nameがない場合、無効である' do
      instrument = FactoryBot.build(:instrument, name: nil)
      instrument.valid?
      expect(instrument.errors[:name]).to include("を入力してください")
    end
  end
end