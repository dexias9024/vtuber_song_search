require 'rails_helper'
  
RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー新規作成' do
    it '1-1.ユーザーの新規作成ができる' do
      visit 'users/new'

      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'パスワード というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード確認'), 'パスワード確認 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'


      fill_in '名前', with: 'test01'
      fill_in 'メールアドレス', with: 'test01@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_on '登録'

      expect(page).to have_button('ログイン'), 'ログインのボタンが表示されていることを確認してください'
      
    end

    it '1-2.同じメールアドレスのユーザーは新規作成できない' do
      user = create(:user)

      visit 'users/new'

      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'パスワード というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード確認'), 'パスワード確認 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect {
        fill_in '名前', with: 'test01'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '登録'
      }.to change { User.count }.by(0)
    end

    it '1-3.入力項目が不足している場合に新規作成ができない' do
      visit 'users/new'

      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'パスワード というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード確認'), 'パスワード確認 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect {
        fill_in '名前', with: nil
        fill_in 'メールアドレス', with: nil
        fill_in 'パスワード', with: nil
        fill_in 'パスワード確認', with: nil
        click_on '登録'
      }.to change { User.count }.by(0)
    end
  end

  describe 'ユーザー編集' do
    before do
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
    end

    it '2-1.ログインしているユーザー情報の編集ができる' do
      sleep 1
      visit edit_user_path(user.id)
      sleep 1

      expect(page).to have_selector('label', text: 'メールアドレス'), 'メールアドレス というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アイコン'), 'アイコン というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'プロフィール'), 'プロフィール というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='user_email']"), 'メールアドレス というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_name']"), '名前 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_icon']"), 'アイコン というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_profile']"), 'プロフィール というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('更新'), '更新用のボタンが表示されていることを確認してください'

      fill_in 'メールアドレス', with: 'user_edited@example.com'
      fill_in '名前', with: 'name_edited'
      file_path = Rails.root.join('spec', 'fixtures', 'test_human.jpg')
      attach_file('アイコン', file_path)
      fill_in 'プロフィール', with: 'Change Profile'

      page.execute_script("window.scrollBy(0, 500);")
      sleep 1
      click_button '更新する'

      expect(page).to have_text('ユーザー情報が正常に更新されました。'), 'ユーザー情報を更新したメッセージが表示されていることを確認してください'
    end
  end 
end