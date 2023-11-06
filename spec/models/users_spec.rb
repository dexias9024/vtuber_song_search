require 'rails_helper'

RSpec.describe 'User', type: :system do
  context "Userを作ることができる" do
    it "1-1.name, email, password, password_confirmationがある場合、有効である" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
    
    it '1-2.nameがない場合、無効である' do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it '1-3.emailがない場合、無効である' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it '1-4.passwordがない場合、無効である' do
      user = FactoryBot.build(:user, password: nil)
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
      user1 = FactoryBot.create(:user, email: 'test@example.com')
      user2 = User.build(name: 'test', 
                       email: 'test@example.com', 
                       password: 'password', 
                       password_confirmation: 'password'
                       )
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end
  end
end