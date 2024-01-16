require 'rails_helper'
  
RSpec.describe "Songs", type: :system do
  describe 'Songの検索' do
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

    it '1-1.song情報を検索できる' do
      sleep 1
      song1 = create(:song, title: 'test1')
      song2 = create(:song, title: 'test2')

      visit songs_path

      expect(page).to have_css('.btn-primary .fas.fa-search'), 'song検索用のボタンが表示されていることを確認してください'

      find_field('search').set('test1')
      find('.btn-primary .fas.fa-search').click

      sleep 1
      expect(page).to have_content(song1.title), '検索結果が表示されていることを確認してください'
      expect(page).not_to have_content(song2.title), '検索していないものが表示されていないことを確認してください'
    end
  end
end