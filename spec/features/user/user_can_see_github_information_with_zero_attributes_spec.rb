# frozen_string_literal: true

require 'rails_helper'

feature 'User can see github information in github section' do
  let(:user) { create(:user, github_token: ENV['TEST_GITHUB_TOKEN']) }

  scenario 'where user has zero repositories' do
    VCR.use_cassette('user/user_has_zero_repositories') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css('.github')
      expect(page).to have_content('GitHub')

      within('.repository') do
        expect(page).to have_content('You currently have no repositories.')
      end

      within('.repository-list') do
        expect(page).to have_selector('.repository-list-link', count: 0)
      end
    end
  end

  scenario 'where user has zero followers' do
    VCR.use_cassette('user/user_has_zero_followers') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css('.github')
      expect(page).to have_content('GitHub')

      within('.follower') do
        expect(page).to have_content("You're not following anyone.")
      end
      \
      within('.follower-list') do
        expect(page).to have_selector('.follower-list-link', count: 0)
      end
    end
  end

  scenario 'where user has zero following' do
    VCR.use_cassette('user/user_has_zero_following') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css('.github')
      expect(page).to have_content('GitHub')

      within('.following') do
        expect(page).to have_content('No one is following you.')
      end

      within('.following-list') do
        expect(page).to have_selector('.following-list-link', count: 0)
      end
    end
  end
end
