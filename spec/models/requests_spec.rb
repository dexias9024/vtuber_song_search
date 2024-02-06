require 'rails_helper'

RSpec.describe 'Request', type: :model do
  context "Requestを作ることができる" do
    it "1-1.user_id, category, name, urlがある場合、有効である" do
      request = build(:request)
      expect(request).to be_valid
    end
    
    it '1-2.user_idがない場合、無効である' do
      request = build(:request, user: nil)
      request.valid?
      expect(request.errors[:user]).to include("を入力してください")
    end

    it '1-3.categoryがない場合、無効である' do
      request = build(:request, category: nil)
      request.valid?
      expect(request.errors[:category]).to include("を入力してください")
    end

    it '1-4.nameがない場合、無効である' do
      request = build(:request, name: nil)
      request.valid?
      expect(request.errors[:name]).to include("を入力してください")
    end

    it '1-5.urlがない場合、無効である' do
      request = build(:request, url: nil)
      request.valid?
      expect(request.errors[:url]).to include("を入力してください")
    end

    it "1-6.重複したurlの場合、無効である" do
      user = create(:user)
      request1 = create(:request, url: 'https://www.youtube.com/test', user_id: user.id)
      request2 = Request.build(user_id: user.id,
                               name: 'test', 
                               url: 'https://www.youtube.com/test', 
                               category: 'Vtuber', 
                              )
      request2.valid?
      expect(request2.errors[:url]).to include("このリクエストは既に投稿されています")
    end
  end
end