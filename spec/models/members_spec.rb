require 'rails_helper'

RSpec.describe 'Member', type: :model do
  context "Memberを作ることができる" do
    it "1-1.nameがある場合、有効である" do
      member = FactoryBot.build(:member)
      expect(member).to be_valid
    end
    
    it '1-2.nameがない場合、無効である' do
      member = FactoryBot.build(:member, name: nil)
      member.valid?
      expect(member.errors[:name]).to include("を入力してください")
    end
  end
end