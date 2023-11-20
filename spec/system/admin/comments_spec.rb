
require 'rails_helper'
  
RSpec.describe "Admin::Comments", type: :system do
  describe 'コメントの削除（管理側）' do
    before do
      admin_user = create(:user, :admin)
      @song = create(:song)

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
    it '1-1.コメントを削除ができる' do
      comment = create(:comment, song: @song)

      visit admin_comments_path

      expect(page).to have_button('削除'), 'コメント削除用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on '削除' }

      sleep 1
      expect(page).to have_text('コメントを削除しました。'), 'コメントを削除したメッセージが表示されていることを確認してください'
    end
  end
end