require 'rails_helper'
  
RSpec.describe "Comments", type: :system do
  describe 'コメント新規作成' do
    before do
      user = create(:user)
      @song = create(:song)

      visit '/login'
    
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      sleep 1
      click_button 'ログイン'
    end
      
    it '1-1.コメントの新規作成ができる' do
      sleep 1
      visit song_path(@song)

      expect(page).to have_selector('label', text: 'コメント'), 'コメント というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='comment_content']"), 'コメント というラベルに対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('投稿'), 'コメント投稿用のボタンが表示されていることを確認してください'
      

      fill_in 'コメント', with: 'test'
      click_on '投稿'

      expect(page).to have_text('コメントを投稿しました。'), 'コメントを投稿したメッセージが表示されていることを確認してください'
    end

    it '1-2.入力項目が不足している場合に新規作成ができない' do
      sleep 1
      visit song_path(@song)


      fill_in 'コメント', with: nil
      click_on '投稿'

      expect(page).to have_text('コメントの投稿に失敗しました。'), 'コメントの投稿に失敗しましたメッセージが表示されていることを確認してください'  
    end

    it '1-3.コメントを削除ができる' do
      sleep 1
      comment = create(:comment, song: @song)

      visit song_path(@song)

      fill_in 'コメント', with: 'test'
      click_on '投稿'

      within ".list-inline-item" do
        find('.js-delete-comment-button').click
      end
      
      expect(page).to have_text('コメントを削除しました。'), 'コメントを削除したメッセージが表示されていることを確認してください'
    end
  end
end