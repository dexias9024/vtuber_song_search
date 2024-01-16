require 'rails_helper'
  
RSpec.describe "Admin::Vtubers", type: :system do 
  describe 'vtuberの新規作成' do
    before do
      admin_user = create(:user, :admin)
      member = create(:member, name: 'test')
      instrument = create(:instrument, name: 'test')
    
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
    it '1-1.vtuberの新規作成ができる' do
      visit 'admin/vtubers/new'

      expect(page).to have_selector('label', text: 'チャンネル名'), 'チャンネル名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アイコン'), 'アイコン というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '概要'), '概要 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='vtuber_channel_name']"), 'チャンネル名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_channel_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_name']"), '名前 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_icon']"), 'アイコン というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_overview']"), '概要 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('vtuber[member_id]', options: ['選択してください'] + Member.pluck(:name)), '所属 ラベルのセレクトボックスの選択肢があることを確認してください'
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'
    

      expect(page).to have_button('登録'), 'vtuberの作成用のボタンが表示されていることを確認してください'

      fill_in 'チャンネル名', with: 'test01'
      fill_in 'URL', with: 'https://www.youtube.com/test01'
      select 'test', from: 'vtuber[member_id]'
      click_on '登録'

      expect(page).to have_content('作成されました'), '作成されましたが表示されていることを確認してください'
    end

    it '1-2.同じチャンネル名のvtuberは新規作成できない' do
      vtuber = create(:vtuber, channel_name: 'test')
      visit 'admin/vtubers/new'

      expect(page).to have_selector('label', text: 'チャンネル名'), 'チャンネル名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アイコン'), 'アイコン というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '概要'), '概要 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='vtuber_channel_name']"), 'チャンネル名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_channel_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_name']"), '名前 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_icon']"), 'アイコン というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_overview']"), '概要 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('vtuber[member_id]', options: ['選択してください'] + Member.pluck(:name)), '所属 ラベルのセレクトボックスの選択肢があることを確認してください'
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'

      expect(page).to have_button('登録'), 'vtuberの作成用のボタンが表示されていることを確認してください'

      
      fill_in 'チャンネル名', with: 'test'
      fill_in 'URL', with: 'https://www.youtube.com/test01'
      select 'test', from: 'vtuber[member_id]'
      click_on '登録'

      expect(page).to have_selector('.alert', text: 'はすでに存在します'), 'はすでに存在しますが表示されていることを確認してください'
    end

    it '1-3.同じURLのvtuberは新規作成できない' do
      vtuber = create(:vtuber, channel_url: 'https://www.youtube.com/test')
      visit 'admin/vtubers/new'

      expect(page).to have_selector('label', text: 'チャンネル名'), 'チャンネル名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アイコン'), 'アイコン というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '概要'), '概要 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='vtuber_channel_name']"), 'チャンネル名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_channel_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_name']"), '名前 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_icon']"), 'アイコン というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_overview']"), '概要 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('vtuber[member_id]', options: ['選択してください'] + Member.pluck(:name)), '所属 ラベルのセレクトボックスの選択肢があることを確認してください'
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'

      expect(page).to have_button('登録'), 'vtuberの作成用のボタンが表示されていることを確認してください'

      fill_in 'チャンネル名', with: 'test'
      fill_in 'URL', with: 'https://www.youtube.com/test'
      select 'test', from: 'vtuber[member_id]'
      click_on '登録'

      expect(page).to have_selector('.alert', text: 'はすでに存在します'), 'はすでに存在しますが表示されていることを確認してください'
    end

    it '1-4.入力項目が不足している場合に新規作成ができない' do
      visit 'admin/vtubers/new'

      expect(page).to have_selector('label', text: 'チャンネル名'), 'チャンネル名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アイコン'), 'アイコン というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '概要'), '概要 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='vtuber_channel_name']"), 'チャンネル名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_channel_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_name']"), '名前 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_icon']"), 'アイコン というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_overview']"), '概要 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('vtuber[member_id]', options: ['選択してください'] + Member.pluck(:name)), '所属 ラベルのセレクトボックスの選択肢があることを確認してください'
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'

      expect(page).to have_button('登録'), 'vtuberの作成用のボタンが表示されていることを確認してください'


      fill_in 'チャンネル名', with: nil
      fill_in 'URL', with: 'https://www.youtube.com/test01'
      select 'test', from: 'vtuber[member_id]'
      click_on '登録'

      expect(page).to have_selector('.alert', text: 'を入力してください'), 'を入力してくださいが表示されていることを確認してください'
    end
  end

  describe 'Vtuberの編集・削除' do
    before do
      admin_user = create(:user, :admin)
      vtuber = create(:vtuber)
      member = create(:member, name: 'test')

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

    it '2-1.Vtuber情報の編集ができる' do
      vtuber = create(:vtuber)
      instrument = create(:instrument, name: 'test')

      visit admin_vtuber_path(vtuber)

      expect(page).to have_link('編集'), '投稿編集用のボタンが表示されていることを確認してください'

      click_on '編集'

      expect(page).to have_selector('label', text: 'チャンネル名'), 'チャンネル名 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'URL'), 'URL というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前'), '名前 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アイコン'), 'アイコン というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '概要'), '概要 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_css("label[for='vtuber_channel_name']"), 'チャンネル名 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_channel_url']"), 'URL というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_name']"), '名前 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_icon']"), 'アイコン というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='vtuber_overview']"), '概要 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_select('vtuber[member_id]', options: Member.pluck(:name)), '所属 ラベルのセレクトボックスの選択肢があることを確認してください'
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'

      expect(page).to have_button('更新'), '更新用のボタンが表示されていることを確認してください'

      fill_in 'チャンネル名', with: 'test02'
      fill_in '名前', with: 'test02'
      select 'test', from: 'vtuber[member_id]'

      click_on '更新'

      expect(page).to have_text('を更新しました。'), 'Vtuber情報を更新したメッセージが表示されていることを確認してください'
    end

    it '2-2.Vtuber情報の削除ができる' do
      vtuber = create(:vtuber)

      visit admin_vtuber_path(vtuber)

      expect(page).to have_button('削除'), 'Vtuber削除用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on '削除' }

      sleep 1
      expect(page).to have_text('を削除しました。'), 'を削除したメッセージが表示されていることを確認してください'
    end
  end

  describe 'Vtuberの検索' do
    before do
      admin_user = create(:user, :admin)

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

    it '3-1.vtuber情報を検索できる' do
      vtuber1 = create(:vtuber, channel_name: 'test1')
      vtuber2 = create(:vtuber, channel_name: 'test2')

      visit admin_vtubers_path

      expect(page).to have_css('.btn-primary .fas.fa-search'), 'vtuber検索用のボタンが表示されていることを確認してください'

      find_field('search').set('test1')
      find('.btn-primary .fas.fa-search').click

      sleep 1
      expect(page).to have_content(vtuber1.channel_name), '検索結果が表示されていることを確認してください'
      expect(page).not_to have_content(vtuber2.channel_name), '検索していないものが表示されていないことを確認してください'
    end
  end
end