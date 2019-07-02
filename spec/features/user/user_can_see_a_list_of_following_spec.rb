require 'rails_helper'

describe 'User' do
  it 'can see list of all github followings in followings section within github section', :vcr do
    user = create(:user, github_token: "7f4390b796ddcfb980618d81ab4b6d2c8cc3c7a0")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)

    within(first(".followings")) do
      expect(page).to have_css('.following-link')
    end

    within(first(".following")) do
      expect(page).to have_link("sbrunswig", href: "https://github.com/sbrunswig")
    end
  end
end