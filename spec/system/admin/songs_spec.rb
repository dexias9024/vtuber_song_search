require 'rails_helper'
  
RSpec.describe "Admin::Songs", type: :system do 
  describe 'songの新規作成' do
    before do
      admin_user = create(:user, :admin)
      vtuber = create(:vtuber, name: 'test')
    
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
    it '1-1.songの新規作成ができる' do
      visit 'admin/songs/new'

      expect(page).to have_selector('label', text: '動画名'), '動画名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '原曲名'), '原曲名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '歌唱Vtuber'), '歌唱Vtuber というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'チャンネル主'), 'チャンネル主 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'カバーかオリジナルか'), 'カバーかオリジナルか というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='song_title']"), '動画名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_video_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_name']"), '原曲名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_artist_name']"), '歌唱Vtuber というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('song[vtuber_id]', options: ['選択してください'] + Vtuber.pluck(:name)), 'チャンネル主 ラベルのセレクトボックスがあることを確認してください'
      expect(page).to have_select('song[cover]', options: ['cover', 'original']), 'カバーかオリジナルか ラベルのセレクトボックスがあることを確認してください'

      expect(page).to have_button('登録'), 'songの作成用のボタンが表示されていることを確認してください'

      fill_in '動画名', with: 'test01'
      fill_in 'URL', with: 'https://www.youtube.com/test01'
      select 'test', from: 'song[vtuber_id]'
      select 'cover', from: 'song[cover]'
      click_on '登録'

      expect(page).to have_content('作成しました'), '作成しましたが表示されていることを確認してください'  
    end

    it '1-2.同じURLのsongは新規作成できない' do
      song = create(:song, video_url: 'https://www.youtube.com/test')
      visit 'admin/songs/new'

      expect(page).to have_selector('label', text: '動画名'), '動画名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '原曲名'), '原曲名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '歌唱Vtuber'), '歌唱Vtuber というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'チャンネル主'), 'チャンネル主 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'カバーかオリジナルか'), 'カバーかオリジナルか というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='song_title']"), '動画名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_video_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_name']"), '原曲名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_artist_name']"), '歌唱Vtuber というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('song[vtuber_id]', options: ['選択してください'] + Vtuber.pluck(:name)), 'チャンネル主 ラベルのセレクトボックスがあることを確認してください'
      expect(page).to have_select('song[cover]', options: ['cover', 'original']), 'カバーかオリジナルか ラベルのセレクトボックスがあることを確認してください'

      expect(page).to have_button('登録'), 'songの作成用のボタンが表示されていることを確認してください'

      
      fill_in '動画名', with: 'test'
      fill_in 'URL', with: 'https://www.youtube.com/test'
      select 'test', from: 'song[vtuber_id]'
      select 'cover', from: 'song[cover]'
      click_on '登録'

      expect(page).to have_selector('.alert', text: 'はすでに存在します'), 'はすでに存在しますが表示されていることを確認してください'
    end

    it '1-3.入力項目が不足している場合に新規作成ができない' do
      visit 'admin/songs/new'

      expect(page).to have_selector('label', text: '動画名'), '動画名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '原曲名'), '原曲名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '歌唱Vtuber'), '歌唱Vtuber というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'チャンネル主'), 'チャンネル主 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'カバーかオリジナルか'), 'カバーかオリジナルか というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='song_title']"), '動画名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_video_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_name']"), '原曲名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_artist_name']"), '歌唱Vtuber というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('song[vtuber_id]', options: ['選択してください'] + Vtuber.pluck(:name)), 'チャンネル主 ラベルのセレクトボックスがあることを確認してください'
      expect(page).to have_select('song[cover]', options: ['cover', 'original']), 'カバーかオリジナルか ラベルのセレクトボックスがあることを確認してください'

      expect(page).to have_button('登録'), 'songの作成用のボタンが表示されていることを確認してください'

      fill_in '動画名', with: nil
      fill_in 'URL', with: 'https://www.youtube.com/test01'
      select 'test', from: 'song[vtuber_id]'
      select 'cover', from: 'song[cover]'
      click_on '登録'

      expect(page).to have_selector('.alert', text: 'を入力してください'), 'を入力してくださいが表示されていることを確認してください'
    end
  end

  describe 'Songの編集・削除' do
    before do
      admin_user = create(:user, :admin)
      vtuber = create(:vtuber, name: 'test')
      song = create(:song)

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

    it '2-1.Song情報の編集ができる' do
      visit admin_songs_path

      expect(page).to have_link('編集'), '投稿編集用のボタンが表示されていることを確認してください'

      click_on '編集'

      expect(page).to have_selector('label', text: '動画名'), '動画名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '原曲名'), '原曲名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '歌唱Vtuber'), '歌唱Vtuber というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'チャンネル主'), 'チャンネル主 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'カバーかオリジナルか'), 'カバーかオリジナルか というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='song_title']"), '動画名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_video_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_name']"), '原曲名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='song_artist_name']"), '歌唱Vtuber というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('song[vtuber_id]', options: Vtuber.pluck(:name)), 'チャンネル主 ラベルのセレクトボックスがあることを確認してください'
      expect(page).to have_select('song[cover]', options: ['cover', 'original']), 'カバーかオリジナルか ラベルのセレクトボックスがあることを確認してください'

      expect(page).to have_button('更新'), '更新用のボタンが表示されていることを確認してください'

      fill_in '動画名', with: 'test02'
      fill_in 'URL', with: 'https://www.youtube.com/test02'
      select 'test', from: 'song[vtuber_id]'
      select 'original', from: 'song[cover]'

      click_on '更新'

      expect(page).to have_text('を更新しました。'), 'song情報を更新したメッセージが表示されていることを確認してください'
    end

    it '2-2.song情報の削除ができる' do
      visit admin_songs_path

      expect(page).to have_button('削除'), 'song削除用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on '削除' }

      sleep 1
      expect(page).to have_text('を削除しました。'), 'を削除したメッセージが表示されていることを確認してください'
    end
  end

  describe 'Songの検索' do
    before do
      admin_user = create(:user, :admin)
      vtuber = create(:vtuber, name: 'test')

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

    it '3-1.song情報を検索できる' do
      song1 = create(:song, title: 'test1')
      song2 = create(:song, title: 'test2')

      visit admin_songs_path

      expect(page).to have_css('.btn-primary .fas.fa-search'), 'song検索用のボタンが表示されていることを確認してください'

      find_field('q[title_or_name_or_artist_name_cont]').set('test1')
      find('.btn-primary .fas.fa-search').click

      sleep 1
      expect(page).to have_content(song1.title), '検索結果が表示されていることを確認してください'
      expect(page).not_to have_content(song2.title), '検索していないものが表示されていないことを確認してください'
    end
  end
end