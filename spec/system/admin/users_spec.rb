
require 'rails_helper'
  
RSpec.describe "Admin::Users", type: :system do
  describe 'ユーザー編集・削除（管理側）' do
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

    it '3-1.他人のユーザー情報の編集ができる' do
      other_user = FactoryBot.create(:user, :general)

      visit admin_user_path(other_user)

      expect(page).to have_link('編集'), '投稿編集用のボタンが表示されていることを確認してください'

      click_on '編集'

      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アイコン'), 'アイコン というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '役職'), '役職 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'プロフィール'), 'プロフィール というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_email']"), 'メールアドレス というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_name']"), '名前 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_icon']"), 'アイコン というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select("user[role]"), '役職 ラベルのセレクトボックスがあることを確認してください'
      expect(page).to have_css("label[for='user_profile']"), 'プロフィール というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('更新'), '更新用のボタンが表示されていることを確認してください'

      fill_in 'メールアドレス', with: 'user_edited@example.com'
      fill_in '名前', with: 'name_edited'
      file_path = Rails.root.join('spec', 'fixtures', 'test_human.jpg')
      attach_file('アイコン', file_path)
      select :admin, from: 'user[role]'
      fill_in 'プロフィール', with: 'Change Profile'

      click_button '更新'

      expect(page).to have_text('ユーザー情報が正常に更新されました。'), 'ユーザー情報を更新したメッセージが表示されていることを確認してください'
    end

    it '3-2.他人のユーザー情報の削除ができる' do
      other_user = FactoryBot.create(:user, :general)

      visit admin_user_path(other_user)

      expect(page).to have_button('削除'), 'ユーザー削除用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on '削除' }

      sleep 1
      expect(page).to have_text('ユーザーを削除しました。'), 'ユーザーを削除したメッセージが表示されていることを確認してください'
      expect(page).not_to have_content(other_user.email), '他人のユーザー情報を削除した直後の画面に、削除した情報が表示されていないことを確認してください'
      expect(page).not_to have_content(other_user.name), '他人の投稿を削除した直後の画面に、削除した情報が表示されていないことを確認してください'
    end
  end
end