require 'rails_helper'
  
RSpec.describe "Password_reset", type: :system do
  let(:user) { create(:user, email: 'test01@example.com') }

  describe 'password_resetの機能' do
    it '1-1.password_resetのメールが送れる' do
      visit 'login'

      expect(page).to have_link('パスワードをお忘れの方はこちら', href: new_password_reset_path), 'パスワードをお忘れの方はこちら というラベルが表示されていることを確認してください'

      click_on 'パスワードをお忘れの方はこちら'

      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_button('送信'), 'パスワードリセット用のメール送信のボタンが表示されていることを確認してください'

      fill_in 'メールアドレス', with: 'test01@example.com'

      click_on '送信'

      expect(page).to have_content('パスワードリセット手順を送信しました'), 'パスワードリセット手順を送信しましたが表示されていることを確認してください'
      expect(page).to have_button('ログイン'), 'ログインのボタンが表示されていることを確認してください' 
    end
  end

  describe 'password_resetでの編集' do
  let!(:user_token_create) { user&.deliver_reset_password_instructions! }
  
    it '1-2.パスワードのリセットができる' do
      visit "/password_resets/#{user.reset_password_token}/edit"

      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'パスワード というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード確認'), 'パスワード確認 というラベルが表示されていることを確認してください'
      expect(page).to have_button('更新する'), 'パスワードリセット用の更新ボタンが表示されていることを確認してください'

      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'

      click_on '更新する'

      expect(page).to have_content('パスワードを変更しました'), 'パスワードを変更の処理が正しく行えるかを確認してください'
      expect(page).to have_button('ログイン'), 'ログアウトのボタンが表示されていることを確認してください'
    end

    it '1-3.入力項目が不足している場合にパスワードのリセットができない' do
      visit "/password_resets/#{user.reset_password_token}/edit"

      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'パスワード というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード確認'), 'パスワード確認 というラベルが表示されていることを確認してください'
      expect(page).to have_button('更新する'), 'パスワードリセット用の更新ボタンが表示されていることを確認してください'

      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: ''

      click_on '更新する'

      expect(page).to have_content('パスワードの変更に失敗しました'), 'パスワードを変更の処理が正しく行えていないかを確認してください'
      expect(page).to have_button('更新する'), 'パスワードリセット用の更新ボタンが表示されていることを確認してください'
    end
  end
end