# frozen_string_literal: true

require 'rails_helper'

feature 'User can friend users who are followed or following on Github' do
  let(:user) { create(:user, github_token: ENV['TEST_TOKEN'], github_id: 18176968, github_handle: 'WHomer') }

  scenario 'can add a friend' do
    VCR.use_cassette('user/has_followers_or_following') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within('.follower-list') do
        expect(page).to have_css('.follower-list-link')
        expect(page).to have_link(href: 'https://github.com/kylecornelissen')
        expect(page).to have_link("Add Friend")
      end

      within('.following-list') do
        expect(page).to have_css('.following-list-link')
        expect(page).to have_link(href: 'https://github.com/kylecornelissen')
        expect(page).to have_link("Add Friend")
      end

      within('following-list') do
        click_on "Add Friend"
      end

      expect(current_path).to eq(dashboard_path)

      within('friendship_list') do
        expect(page).to have_css(".friend-name")
      end

    end
  end
end