require 'rails_helper'
  
RSpec.describe "Admin::Inquiries", type: :system do 
  describe 'inquiriesのcloseと削除' do
    before do
      admin_user = create(:user, :admin)
      inquiry = create(:inquiry)
    
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
    
    it '1-1.inquiryをcloseにできる' do
      visit admin_inquiries_path

      expect(page).to have_button('Close'), 'inquiryclose用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on 'Close' }

      sleep 1
      expect(page).to have_text('をクローズにしました。'), 'をcloseしたメッセージが表示されていることを確認してください'
    end

    it '1-2.inquiry情報の削除ができる' do
      visit admin_inquiries_path

      expect(page).to have_button('削除'), 'inquiry削除用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on '削除' }

      sleep 1
      expect(page).to have_text('を削除しました。'), 'を削除したメッセージが表示されていることを確認してください'
    end
  end
end