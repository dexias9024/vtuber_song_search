require 'rails_helper'
  
RSpec.describe "Admin::Members", type: :system do
  describe '所属の新規作成' do
    before do
      admin_user = FactoryBot.create(:user, :admin)
    
      visit '/admin'
    
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
    
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
    
      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'
    
      fill_in 'Email', with: admin_user.email
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    it '1-1.所属の新規作成ができる' do
      visit 'admin/members/new'

      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='member_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), '所属の作成用のボタンが表示されていることを確認してください'

      fill_in '名前', with: 'test01'
      click_on '登録'

      expect(page).to have_text('作成しました'), '作成しましたが表示されていることを確認してください'  
    end

    it '1-2.同じ名前の所属は新規作成できない' do
      member = FactoryBot.create(:member, name: 'test')

      visit 'admin/members/new'

      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='member_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), '所属の作成用のボタンが表示されていることを確認してください'

      visit 'admin/members/new'

      fill_in '名前', with: 'test'
      click_on '登録'

      expect(page).to have_text('はすでに存在します'), 'はすでに存在しますが表示されていることを確認してください'
    end

    it '1-3.入力項目が不足している場合に新規作成ができない' do
      visit 'admin/members/new'

      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='member_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), '所属の作成用のボタンが表示されていることを確認してください'

      fill_in '名前', with: nil
      click_on '登録'

      expect(page).to have_selector('.alert', text: 'を入力してください'), 'を入力してくださいが表示されていることを確認してください'
    end
  end
end