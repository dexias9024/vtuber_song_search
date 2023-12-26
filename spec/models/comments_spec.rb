require 'rails_helper'

RSpec.describe 'comment', type: :model do
  context "commentを作ることができる" do
    it "1-1.contentがある場合、有効である" do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end
    
    it '1-2.contentがない場合、無効である' do
      comment = FactoryBot.build(:comment, content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include("を入力してください")
    end

    it '1-3.contentの値が5000文字以上の場合、無効である' do
      comment = FactoryBot.build(:comment, content: 'a' * 5001)
      comment.valid?
      expect(comment.errors[:content]).to include("は5000文字以内で入力してください")
    end
  end
  
  describe 'commentの検索' do
    it '2-1.検索結果に一致するものだけ取得する' do
      comment1 = create(:comment, content: 'test1')
      comment2 = create(:comment, content: 'test2')

      search_params = { content_cont: 'test1' }
      results = Comment.ransack(search_params).result

      expect(results).to include(comment1)
      expect(results).not_to include(comment2)
    end
  end
end