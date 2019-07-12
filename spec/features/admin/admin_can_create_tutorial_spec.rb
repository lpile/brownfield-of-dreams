# frozen_string_literal: true

require 'rails_helper'

feature 'An Admin can create a new tutorial' do
  let(:admin) { create(:admin) }

  scenario 'by clicking on the new tutorial button' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on 'New Tutorial'

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'New Tutorial'
    fill_in 'tutorial[description]', with: 'Description for new tutorial'
    fill_in 'tutorial[thumbnail]', with: 'ad35FSSos9'
    click_on 'Save'

    new_tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(new_tutorial))
  end
end
