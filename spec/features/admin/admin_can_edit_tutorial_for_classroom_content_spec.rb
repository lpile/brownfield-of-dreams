# frozen_string_literal: true

require 'rails_helper'

feature 'An Admin can edit a tutorial' do
  let(:admin) { create(:admin) }

  scenario 'to be classroom content' do
    VCR.use_cassette('admin/can_change_tutorial_classroom_content') do
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(admin)

      tutorial = create(:tutorial)

      visit admin_dashboard_path

      within(first('.admin-tutorial-card')) do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

      expect(tutorial.classroom).to eq(false)

      click_on 'Classroom Content'

      expect(tutorial.reload.classroom).to eq(true)

      click_on 'Visitor Content'

      expect(tutorial.reload.classroom).to eq(false)
    end
  end
end
