require 'rails_helper'
  
RSpec.describe "Requests", type: :system do
  describe 'リクエストの新規作成' do
    before do
      user = create(:user)
      instrument = create(:instrument, name: 'test')

      visit '/login'
    
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      sleep 1
      click_button 'ログイン'
    end

    it '1-1.Vtuberリクエストの新規作成ができる' do
      sleep 1
      visit new_request_path

      expect(page).to have_selector('label', text: 'リクエストの種類'), 'リクエストの種類 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前(必須)'), '名前(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '動画のURL(必須)'), '動画のURL(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_field('request[category]', with: 'Vtuber', readonly: true), 'リクエストの種類 というラベルの値がVtuberになっているか確認してください'
      expect(page).to have_css("label[for='request_name']"), '名前(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='request_url']"), '動画のURL(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='request_member_name']"), '所属 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      page.execute_script("window.scrollBy(0, 500);")
      sleep 1
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      
      expect(page).to have_selector('turbo-frame#request_form') do
        fill_in '名前(必須)', with: 'test01'
        fill_in '動画のURL(必須)', with: 'https://www.youtube.com/watch?v=test01'
        fill_in '所属', with: '個人勢'
        click_on '登録'

        sleep 1
        expect(page).to have_selector('.alert.alert-success', text: 'リクエストを投稿しました。')
      end
    end

    it '1-2.歌リクエストの新規作成ができる' do
      sleep 1
      visit new_request_path

      click_on '歌リクエスト'

      expect(page).to have_selector('label', text: 'リクエストの種類'), 'リクエストの種類 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前(必須)'), '名前(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '動画のURL(必須)'), '動画のURL(必須) というラベルが表示されていることを確認してください'

      expect(page).to have_field('request[category]', with: '歌', readonly: true), 'リクエストの種類 というラベルの値が歌になっているか確認してください'
      expect(page).to have_css("label[for='request_name']"), '名前(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='request_url']"), '動画のURL(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect(page).to have_selector('turbo-frame#request_form') do
        fill_in '名前(必須)', with: 'test01'
        fill_in '動画のURL(必須)', with: 'https://www.youtube.com/watch?v=test01'
        click_on '登録'

        sleep 1
        expect(page).to have_selector('.alert.alert-success', text: 'リクエストを投稿しました。')
      end
    end

    it '1-3.入力項目が不足している場合に新規作成ができない' do
      sleep 1
      visit new_request_path

      expect(page).to have_selector('label', text: 'リクエストの種類'), 'リクエストの種類 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前(必須)'), '名前(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '動画のURL(必須)'), '動画のURL(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_field('request[category]', with: 'Vtuber', readonly: true), 'リクエストの種類 というラベルの値がVtuberになっているか確認してください'
      expect(page).to have_css("label[for='request_name']"), '名前(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='request_url']"), '動画のURL(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='request_member_name']"), '所属 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      page.execute_script("window.scrollBy(0, 500);")
      sleep 1
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect(page).to have_selector('turbo-frame#request_form') do
        expect {
          fill_in '名前(必須)', with: nil
          fill_in '動画のURL(必須)', with: nil
          fill_in '所属', with: '個人勢'
          click_on '登録'
        }.to change { Request.count }.by(0)

        expect(page).to have_selector('turbo-frame#request_form'), 'エラーメッセージが表示されていることを確認してください'
      end
    end

    it '1-4.同じURLのリクエストは作成できない' do
      sleep 1
      request = create(:request, url: "https://www.youtube.com/watch?v=test01")

      visit new_request_path

      expect(page).to have_selector('label', text: 'リクエストの種類'), 'リクエストの種類 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '名前(必須)'), '名前(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '動画のURL(必須)'), '動画のURL(必須) というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '所属'), '所属 というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '演奏楽器'), '演奏楽器 というラベルが表示されていることを確認してください'

      expect(page).to have_field('request[category]', with: 'Vtuber', readonly: true), 'リクエストの種類 というラベルの値がVtuberになっているか確認してください'
      expect(page).to have_css("label[for='request_name']"), '名前(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='request_url']"), '動画のURL(必須) というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='request_member_name']"), '所属 というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      page.execute_script("window.scrollBy(0, 500);")
      sleep 1
      click_on '楽器一覧'
      expect(page).to have_unchecked_field('test'), '演奏楽器 ラベルのチェックボックスの選択肢があることを確認してください'

      expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      expect(page).to have_selector('turbo-frame#request_form') do
        expect {
          fill_in '名前(必須)', with: 'test01'
          fill_in '動画のURL(必須)', with: 'https://www.youtube.com/watch?v=test01'
          fill_in '所属', with: '個人勢'
          click_on '登録'
        }.to change { Request.count }.by(0)

        expect(page).to have_selector('turbo-frame#request_form'), 'エラーメッセージが表示されていることを確認してください'
      end
    end
  end
end