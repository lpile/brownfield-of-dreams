require 'rails_helper'

describe 'User' do
  it 'can see list of up to five repos in github section', :vcr do
    user = create(:user, github_token: "7f4390b796ddcfb980618d81ab4b6d2c8cc3c7a0")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)

    within(first(".repo")) do
      expect(page).to have_css('.html_url')
    end

    within(first(".repo")) do
      expect(page).to have_link("NYT-Api-Activity", href: "https://github.com/bexway/NYT-Api-Activity")
    end

    expect(page).to have_selector('.repo', count: 5)

  end

  it 'will not show github section if user has no github_token' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)

    expect(page).to_not have_css('.github')
  end
end