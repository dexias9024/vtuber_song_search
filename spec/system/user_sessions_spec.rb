require 'rails_helper'
  
RSpec.describe "UserSessions", type: :system do
  describe 'ユーザーログイン' do
    it '1-1.ユーザーのログインができる' do
      user = create(:user)

      visit '/login'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'ログイン'

      expect(page).to have_content('ログインしました'), 'ログイン処理が正しく行えるかを確認してください'
      expect(page).to have_button('ログアウト'), 'ログアウトのボタンが表示されていることを確認してください'
    end

    it '1-2.入力項目が不足している場合にログインができない' do
      user = create(:user)

      visit '/login'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: nil
      fill_in 'Password', with: nil
      click_button 'ログイン'

      expect(current_path).not_to eq('/songs'), '入力項目が不足している場合にログインできていないかを確認してください'
      expect(current_path).to eq('/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '1-3.存在しないユーザーでログインができない' do
      user = create(:user)

      visit '/login'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: 'another_user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'

      expect(current_path).not_to eq('/songs'), '存在しないユーザーでログインできていないかを確認してください'
      expect(current_path).to eq('/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '1-4.パスワードが間違っている場合にログインができない' do
      user = create(:user)

      visit '/login'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrong_password'
      click_button 'ログイン'

      expect(current_path).not_to eq('/songs'), 'パスワードが間違っている場合にログインできていないかを確認してください'
      expect(current_path).to eq('/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end
  end

  describe 'ユーザーログアウト' do
    it '2-1.ユーザーのログアウトができる' do
      user = create(:user)

      visit '/login'

      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'ログイン'

      find_button('ログアウト').click

      expect(page).to have_button('ログイン'), 'ログアウトができているかを確認してください'
    end

    it '2-2.ログインしていない場合、ユーザーのログアウトリンクが表示されない' do
      visit '/login'

      expect(page).not_to have_link('ログアウト'), 'ログインしていない場合でも、ログアウトリンクが表示されています'
    end
  end

  describe 'ゲストログイン' do
    it '3-1.ゲストログインができる' do
      user = create(:user)

      visit '/login'

      expect(page).to have_button('ゲストログイン'), 'ゲストログイン用のボタンが表示されていることを確認してください'

      click_button 'ゲストログイン'

      expect(page).to have_button('ログアウト'), 'ログアウトのボタンが表示されていることを確認してください'
      expect(page).to have_content('ゲスト'), 'ゲストとしてログインしたことを画面に表示していることを確認してください'
    end
  end
end