# frozen_string_literal: true

require 'rails_helper'

feature 'User connecting to Github' do
  let(:user1) { create(:user, github_token: ENV['GITHUB_TOKEN']) }
  let(:user2) { create(:user, github_token: nil) }

  scenario 'user does not have token already trys to connect to Github' do
    VCR.use_cassette('user/can_see_five_repositories') do
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user2)

      visit dashboard_path

      expect(page).to have_link('Connect to GitHub')

      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        :provider => 'github',
        'credentials' => { 'token' => '123545' }
      )

      click_on 'Connect to GitHub'

      expect(user2.github_token).to eq('123545')
    end
  end

  scenario 'user has token and does not see link to connect' do
    VCR.use_cassette('user/can_see_five_repositories') do
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user1)

      visit dashboard_path

      expect(page).to have_no_link('Connect to GitHub')
    end
  end
end
