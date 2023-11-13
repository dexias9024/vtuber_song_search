require 'rails_helper'

RSpec.describe 'Vtuber', type: :model do
  context "Vtuberを作ることができる" do
    it "1-1.channel_name, channel_url, memberがある場合、有効である" do
      vtuber = FactoryBot.build(:vtuber)
      expect(vtuber).to be_valid
    end
    
    it '1-2.channel_nameがない場合、無効である' do
      vtuber = FactoryBot.build(:vtuber, channel_name: nil)
      vtuber.valid?
      expect(vtuber.errors[:channel_name]).to include("を入力してください")
    end

    it '1-3.channel_urlがない場合、無効である' do
      vtuber = FactoryBot.build(:vtuber, channel_url: nil)
      vtuber.valid?
      expect(vtuber.errors[:channel_url]).to include("を入力してください")
    end

    it '1-4.member_idがない場合、無効である' do
      vtuber = FactoryBot.build(:vtuber, member: nil)
      vtuber.valid?
      expect(vtuber.errors[:member]).to include("を入力してください")
    end

    it "1-5.重複したチャンネル名の場合、無効である" do
      vtuber1 = FactoryBot.create(:vtuber, channel_name: 'test')
      vtuber2 = Vtuber.build(channel_name: 'test', 
                            channel_url: 'https://www.youtube.com/test', 
                            member_id: 1, 
                            )
      vtuber2.valid?
      expect(vtuber2.errors[:channel_name]).to include("はすでに存在します")
    end

    it "1-6.重複したチャンネルURLの場合、無効である" do
      vtuber1 = FactoryBot.create(:vtuber, channel_url: 'https://www.youtube.com/test')
      vtuber2 = Vtuber.build(channel_name: 'test', 
                            channel_url: 'https://www.youtube.com/test', 
                            member_id: 1, 
                            )
      vtuber2.valid?
      expect(vtuber2.errors[:channel_url]).to include("はすでに存在します")
    end
  end
end