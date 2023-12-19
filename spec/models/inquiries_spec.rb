require 'rails_helper'

RSpec.describe 'Inquiry', type: :model do
  context "Inquiryを作ることができる" do
    it "1-1.name, email, contentがある場合、有効である" do
      inquiry = FactoryBot.build(:inquiry)
      expect(inquiry).to be_valid
    end
    
    it '1-2.nameがない場合、無効である' do
      inquiry = FactoryBot.build(:inquiry, name: nil)
      inquiry.valid?
      expect(inquiry.errors[:name]).to include("を入力してください")
    end

    it '1-3.emailがない場合、無効である' do
      inquiry = FactoryBot.build(:inquiry, email: nil)
      inquiry.valid?
      expect(inquiry.errors[:email]).to include("を入力してください")
    end

    it '1-4.contentがない場合、無効である' do
      inquiry = FactoryBot.build(:inquiry, content: nil)
      inquiry.valid?
      expect(inquiry.errors[:content]).to include("を入力してください")
    end

    it '1-5.nameの値が50文字以上の場合、無効である' do
      inquiry = FactoryBot.build(:inquiry, name: 'a' * 51)
      inquiry.valid?
      expect(inquiry.errors[:name]).to include("は50文字以内で入力してください")
    end

    it '1-6.emailの値が100文字以上の場合、無効である' do
      inquiry = FactoryBot.build(:inquiry, email: 'a' * 101 + '@example.com')
      inquiry.valid?
      expect(inquiry.errors[:email]).to include("は100文字以内で入力してください")
    end

    it '1-7.contentが2000字以上ある場合、無効である' do
      inquiry = FactoryBot.build(:inquiry, content: 'a' * 2001)
      inquiry.valid?
      expect(inquiry.errors[:content]).to include("は2000文字以内で入力してください")
    end
  end
end