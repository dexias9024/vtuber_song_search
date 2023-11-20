
require 'rails_helper'
  
RSpec.describe "Admin::UserSessions", type: :system do
  describe 'ユーザーログイン（管理側）' do
    it '1-1.admin権限のあるユーザーでログインができる' do
      admin_user = create(:user, :admin)

      visit '/admin'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: admin_user.email
      fill_in 'Password', with: 'password'
      click_button 'ログイン'

      expect(current_path).not_to eq('/admin/login'), 'ログイン処理が正しく行えるかを確認してください'
      expect(current_path).to eq('/admin'), 'ログイン後に管理画面に遷移できていません'
    end

    it '1-2.admin権限のないユーザーでログインができない' do
      general_user = create(:user, :general)

      visit '/admin'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: general_user.email
      fill_in 'Password', with: nil
      click_button 'ログイン'

      expect(current_path).not_to eq('/admin'), 'admin権限のないユーザーでログインできていないかを確認してください'
      expect(current_path).to eq('/admin/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '1-3.存在しないユーザーでログインができない' do
      admin_user = create(:user, :admin)

      visit '/admin'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: 'another_user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'

      expect(current_path).not_to eq('/admin'), '存在しないユーザーでログインできていないかを確認してください'
      expect(current_path).to eq('/admin/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '1-4.パスワードが間違っている場合にログインができない' do
      admin_user = create(:user, :admin)

      visit '/admin'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: admin_user.email
      fill_in 'Password', with: 'wrong_password'
      click_button 'ログイン'

      expect(current_path).not_to eq('/admin'), 'パスワードが間違っている場合にログインできていないかを確認してください'
      expect(current_path).to eq('/admin/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end
  end

  describe 'adminユーザーログアウト' do
    it '2-1.ユーザーのログアウトができる' do
      admin_user = create(:user, :admin) # describe使わないので、let!を使わずに記載

      visit '/admin'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: admin_user.email
      fill_in 'Password', with: 'password'
      click_button 'ログイン'

      expect(page).to have_button('ログアウト'), 'ログアウトのボタンが表示されていることを確認してください'

      page.accept_confirm { click_on 'ログアウト' }

      expect(page).to have_button('ログイン'), 'ログアウトができているかを確認してください'
    end

    it '2-2.ログインしていない場合、ユーザーのログアウトリンクが表示されない' do
      visit '/admin'

      expect(page).not_to have_button('ログアウト'), 'ログインしていない場合でも、ログアウトリンクが表示されています'
    end
  end
end
