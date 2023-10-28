require 'rails_helper'
  
RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー新規作成' do
    it '1-1.ユーザーの新規作成ができる' do
      visit 'users/new'

      expect(page).to have_selector('label', text: 'Name'), 'Name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect {
        fill_in 'Name', with: 'test01'
        fill_in 'Email', with: 'test01@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on '登録'
      }.to change { User.count }.by(1)
      expect(page).to have_button('ログイン'), 'ログインのボタンが表示されていることを確認してください'
    end

    it '1-2.同じメールアドレスのユーザーは新規作成できない' do
      user = FactoryBot.create(:user)

      visit 'users/new'

      expect(page).to have_selector('label', text: 'Name'), 'Name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect {
        fill_in 'Name', with: 'test01'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on '登録'
      }.to change { User.count }.by(0)
    end

    it '1-3.入力項目が不足している場合に新規作成ができない' do
      visit 'users/new'

      expect(page).to have_selector('label', text: 'Name'), 'Name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect {
        fill_in 'Name', with: nil
        fill_in 'Email', with: nil
        fill_in 'Password', with: nil
        fill_in 'Password confirmation', with: nil
        click_on '登録'
      }.to change { User.count }.by(0)
    end
  end
end