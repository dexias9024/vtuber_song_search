require 'rails_helper'
  
RSpec.describe "Inquiries", type: :system do
  describe 'お問合せの新規作成' do
    before do
      user = create(:user)

      visit '/login'
    
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      sleep 1
      click_button 'ログイン'
    end

    it '1-1.お問合せの新規作成ができる' do
      sleep 1
      visit new_inquiry_path

      expect(page).to have_selector('label', text: '名前(必須)'), '名前(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'メールアドレス(必須)'), 'メールアドレス(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'お問合せ内容'), 'お問合せ内容 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='inquiry_name']"), '名前(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='inquiry_email']"), 'メールアドレス(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='inquiry_content']"), 'お問合せ内容 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'お問合せ作成用のボタンが表示されていることを確認してください'

      fill_in '名前(必須)', with: 'test01'
      fill_in 'メールアドレス(必須)', with: 'test@example.com'
      fill_in 'お問合せ内容', with: 'test'
      click_on '登録'

      sleep 1
      expect(page).to have_content('を投稿しました。'), 'を投稿しました。が表示されていることを確認してください'
    end

    it '1-2.入力項目が不足している場合に新規作成ができない' do
      sleep 1
      visit new_inquiry_path

      expect(page).to have_selector('label', text: '名前(必須)'), '名前(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'メールアドレス(必須)'), 'メールアドレス(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'お問合せ内容'), 'お問合せ内容 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='inquiry_name']"), '名前(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='inquiry_email']"), 'メールアドレス(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='inquiry_content']"), 'お問合せ内容 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'お問合せ作成用のボタンが表示されていることを確認してください'

      expect {
        fill_in '名前(必須)', with: nil
        fill_in 'メールアドレス(必須)', with: 'test@example.com'
        fill_in 'お問合せ内容', with: 'test'
        click_on '登録'
      }.to change { Inquiry.count }.by(0)

      sleep 1
      expect(page).to have_content('を入力してください'), 'を入力してくださいが表示されていることを確認してください'
    end

    it '1-3.文字数制限を超えている場合に新規作成ができない' do
      sleep 1
      visit new_inquiry_path

      expect(page).to have_selector('label', text: '名前(必須)'), '名前(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'メールアドレス(必須)'), 'メールアドレス(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'お問合せ内容'), 'お問合せ内容 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='inquiry_name']"), '名前(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='inquiry_email']"), 'メールアドレス(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='inquiry_content']"), 'お問合せ内容 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'お問合せ作成用のボタンが表示されていることを確認してください'

      expect {
        fill_in '名前(必須)', with: 'test'
        fill_in 'メールアドレス(必須)', with: 'test@example.com'
        fill_in 'お問合せ内容', with: 'a' * 2001
        click_on '登録'
      }.to change { Inquiry.count }.by(0)

      sleep 1
      expect(page).to have_content('文字以内で入力してください'), '文字以内で入力してくださいが表示されていることを確認してください'
    end
  end
end