require 'rails_helper'
  
RSpec.describe "Favorites", type: :system do
  describe 'お気に入り作成と削除' do
    before do
      @user = create(:user)
      @song = create(:song)

      visit '/login'
    
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      sleep 1
      click_button 'ログイン'
    end
      
    it '1-1.お気に入りになっていない場合白いハートボタンが表示される' do
      sleep 1
      visit song_path(@song)
      expect(page).to have_css('i.far')
    end

    it '1-2.お気に入りになっている場合青いハートボタンが表示される' do
      sleep 1
      #@favorite = create(:favorite, user: @user, song: @song)
      visit song_path(@song)
      expect(page).to have_css('i.far')
      find(".far.fa-heart").click
      expect(page).to have_css('i.fas')
    end

    it '1-3.お気に入りを削除できる' do
      sleep 1
      visit song_path(@song)
      expect(page).to have_css('i.far')
      find(".far.fa-heart").click
      expect(page).to have_css('i.fas')
      find(".fas.fa-heart").click
      expect(page).to have_css('i.far')
    end

    it '1-4.お気に入り一覧に追加できている' do
      sleep 1
      @favorite = create(:favorite, user: @user, song: @song)

      visit favorites_songs_path
      
      expect(page).to have_text('cover')
    end

    it '1-5.お気に入りがない場合お気に入り一覧に何もない' do
      sleep 1
      visit favorites_songs_path
      expect(page).to have_text('登録された曲はありません')
    end
  end
end