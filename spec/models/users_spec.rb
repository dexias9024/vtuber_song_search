require 'rails_helper'

RSpec.describe 'User', type: :model do
  context "Userを作ることができる" do
    it "1-1.name, email, password, password_confirmationがある場合、有効である" do
      user = build(:user)
      expect(user).to be_valid
    end
    
    it '1-2.nameがない場合、無効である' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it '1-3.emailがない場合、無効である' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it '1-4.passwordがない場合、無効である' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it '1-5.passwordとpassword_confirmationが異なる場合、無効である' do
      user = User.new(name: 'test', 
                      email: 'test@example.com', 
                      password: 'password', 
                      password_confirmation: 'pass'
                     )
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "1-6.重複したメールアドレスの場合、無効である" do
      user1 = create(:user, email: 'test@example.com')
      user2 = User.build(name: 'test', 
                         email: 'test@example.com', 
                         password: 'password', 
                         password_confirmation: 'password'
                        )
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    it '1-7.passwordの値が5文字以下の場合、無効である' do
      user = build(:user, password: 'a' * 5)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it '1-7.nameの値が50文字以上の場合、無効である' do
      user = build(:user, name: 'a' * 51)
      user.valid?
      expect(user.errors[:name]).to include("は50文字以内で入力してください")
    end

    it '1-8.emailの値が100文字以上の場合、無効である' do
      user = build(:user, email: 'a' * 101 + '@example.com')
      user.valid?
      expect(user.errors[:email]).to include("は100文字以内で入力してください")
    end
  end

  describe 'userの検索' do
    it '2-1.検索結果に一致するものだけ取得する' do
      user1 = create(:user, name: 'test1')
      user2 = create(:user, name: 'test2')

      results = User.search_by_name('test1')

      expect(results).to include(user1)
      expect(results).not_to include(user2)
    end
  end
end