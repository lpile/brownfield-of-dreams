require 'rails_helper'

describe 'User' do
  it 'can see list of all github followers in followers section within github section', :vcr do
    user = create(:user, github_token: "7f4390b796ddcfb980618d81ab4b6d2c8cc3c7a0")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)

    within(first(".followers")) do
      expect(page).to have_css('.follower-link')
    end

    within(first(".follower")) do
      expect(page).to have_link("frankstepanski", href: "https://github.com/frankstepanski")
    end
  end
end