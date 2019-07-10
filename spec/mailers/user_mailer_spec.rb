# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'registration_confirmation' do
    let(:user) do
      create(:user,
             github_token: ENV['TEST_GITHUB_TOKEN'],
             confirm_token: '232425lkjkjh2khj3')
    end

    let(:mail) { UserMailer.registration_confirmation(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Brownfield Account Activation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['register@brownfield-turing.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://localhost:3000/#{user.confirm_token}/confirm_email")
    end
  end
end
