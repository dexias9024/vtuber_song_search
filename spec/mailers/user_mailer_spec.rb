require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  
  describe 'passwordの再設定' do
    let(:user) { create(:user) }
    let!(:user_token_create) { user&.deliver_reset_password_instructions! }
    let(:mail) { UserMailer.reset_password_email(user) }
    let(:text_body) { mail.text_part ? mail.text_part.decoded : mail.body.decoded }
    let(:html_body) { mail.html_part ? mail.html_part.decoded : nil }
    context 'ActionMailerの送信' do
      it 'メール文が正しく表示されること' do
        expect(text_body).to match edit_password_reset_url(user.reset_password_token)
        expect(html_body).to match edit_password_reset_url(user.reset_password_token)
        expect(text_body).to match(user.name)
      end
    end
  end
end
