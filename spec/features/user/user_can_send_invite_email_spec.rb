require 'rails_helper'

feature 'User can send invite email via github handle' do
  let(:user) { create(:user, github_token: ENV['TEST_GITHUB_TOKEN']) }

  scenario 'by entering a github handle with public email' do
    VCR.use_cassette('user/can_send_invite_with_public_email') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css('.github')
      expect(page).to have_content('GitHub')

      within('.invite') do
        fill_in 'github_handle', with: 'WHomer'
        click_on 'Invite Them'
      end

      expect(page).to have_content('Successfully sent invite!')
      expect(current_path).to eq(dashboard_path)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  scenario 'by entering a github handle without public email' do
    VCR.use_cassette('user/can_send_invite_without_public_email') do
      ActionMailer::Base.deliveries = []
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css('.github')
      expect(page).to have_content('GitHub')

      within('.invite') do
        fill_in 'github_handle', with: 'james-cape'
        click_on 'Invite Them'
      end

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
      expect(current_path).to eq(dashboard_path)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end
end
