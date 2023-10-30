
require 'rails_helper'
  
RSpec.describe "Admin::Users", type: :system do
  describe 'ユーザー編集・削除（管理側）' do
    before do
      # テストデータの用意
      admin_user = create(:user, :admin)

      # 確認対象の画面に移動
      visit '/admin'
    
      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
    
      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
    
      # ログイン用ボタンの存在確認
      expect(page).to have_button('Login'), 'ログイン用のボタンが表示されていることを確認してください'
    
      # ユーザーログイン処理
      fill_in 'Email', with: admin_user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    it '3-1.他人のユーザー情報の編集ができる' do
      # テストデータの用意
      other_user = create(:user, :general)

      # 確認対象の画面に移動
      visit admin_user_path(other_user)

      # 編集用ボタンの存在確認
      expect(page).to have_link('Edit'), '投稿編集用のボタンが表示されていることを確認してください'

      click_on 'Edit'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Last name'), 'Last name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'First name'), 'First name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Avatar'), 'Avatar というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Role'), 'Role というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_last_name']"), 'Last name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_first_name']"), 'First name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_avatar']"), 'Avatar というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_role']"), 'Role というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # 更新用ボタンの存在確認
      expect(page).to have_button('Update User'), '更新用のボタンが表示されていることを確認してください'

      # ユーザー情報更新処理
      fill_in 'Email', with: 'user_edited@example.com'
      fill_in 'Last name', with: 'last_name_edited'
      fill_in 'First name', with: 'first_name_edited'
      file_path = Rails.root.join('spec', 'fixtures', 'runteq.png')
      attach_file('Avatar', file_path)
      select :admin, from: 'user[role]'

      click_button 'Update User'

      expect(current_path).to eq('/admin/users'), '投稿編集後に一覧画面に遷移していることを確認してください'
      expect(page).to have_content('user_edited@example.com'), '他人の投稿を更新した直後の画面に、更新した情報が表示されていることを確認してください'
      expect(page).to have_content('last_name_edited'), '他人の投稿を更新した直後の画面に、更新した情報が表示されていることを確認してください'
      expect(page).to have_content('first_name_edited'), '他人の投稿を更新した直後の画面に、更新した情報が表示されていることを確認してください'
      expect(other_user.reload.avatar.to_s.include?('runteq.png')).to be(true), '他人の投稿を更新した直後の画面に、更新した情報が表示されていることを確認してください'
      expect(page).to have_content('admin'), '他人の投稿を更新した直後の画面に、更新した情報が表示されていることを確認してください'
      expect(page).not_to have_content('general'), '他人の投稿を更新した直後の画面に、更新した情報が表示されていることを確認してください'
    end

    it '3-2.他人のユーザー情報の削除ができる' do
      # テストデータの用意
      other_user = create(:user, :general)
      
      # 確認対象の画面に移動
      visit admin_user_path(other_user)

      # 削除用ボタンの存在確認
      expect(page).to have_link('Delete'), '投稿削除用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on 'Delete' }

      sleep 1 # 削除処理の完了まで待機
      expect(current_path).to eq('/admin/users'), '投稿削除後に一覧画面に遷移していることを確認してください'
      expect(page).not_to have_content(other_user.email), '他人のユーザー情報を削除した直後の画面に、削除した情報が表示されていないことを確認してください'
      expect(page).not_to have_content(other_user.first_name), '他人の投稿を削除した直後の画面に、削除した情報が表示されていないことを確認してください'
    end
  end
end