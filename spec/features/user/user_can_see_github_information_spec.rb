# frozen_string_literal: true

require 'rails_helper'

feature 'User can see github information in github section' do
  let(:user1) { create(:user, github_token: ENV['GITHUB_TOKEN']) }
  let(:user2) { create(:user) }

  scenario 'where five repositories are listed' do
    VCR.use_cassette('user/can_see_five_repositories') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css('.github')
      expect(page).to have_content("GitHub")

      within('.repository-list') do
        expect(page).to have_css('.repository-list-link')
        expect(page).to have_link('NYT-Api-Activity', href: 'https://github.com/bexway/NYT-Api-Activity')
        expect(page).to have_selector('.repository-list-link', count: 5)
      end
    end
  end

  scenario 'where github followers are listed' do
    VCR.use_cassette('user/can_see_followers') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit dashboard_path

      within('.github') do
        expect(page).to have_css('.follower')
        expect(page).to have_content("Followers")
      end

      within('.follower-list') do
        expect(page).to have_css('.follower-list-link')
        expect(page).to have_link('frankstepanski', href: 'https://github.com/frankstepanski')
      end
    end
  end

  scenario 'where github following are listed' do
    VCR.use_cassette('user/can_see_following') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit dashboard_path

      within('.github') do
        expect(page).to have_css('.following')
        expect(page).to have_content("Following")
      end

      within('.following-list') do
        expect(page).to have_css('.following-list-link')
        expect(page).to have_link('sbrunswig', href: 'https://github.com/sbrunswig')
      end
    end
  end

  context 'edge cases' do
    scenario 'will not show github section if user has no github_token' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_css('.github')
    end
  end
end
