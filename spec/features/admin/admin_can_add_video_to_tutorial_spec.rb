# frozen_string_literal: true

require 'rails_helper'

feature 'An Admin can add new video to blank tutorial' do
  let(:admin) { create(:admin) }

  scenario 'by clicking on the add video button' do
    VCR.use_cassette('admin/can_add_video_to_tutorial') do
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_on 'New Tutorial'

      fill_in 'tutorial[title]', with: 'New Tutorial'
      fill_in 'tutorial[description]', with: 'Description for new tutorial'
      fill_in 'tutorial[thumbnail]', with: 'ad35FSSos9'
      click_on 'Save'

      tutorial = Tutorial.last

      click_on 'Add Video'

      part1 = 'Over, under, around and through, '
      part2 = 'Meet Mr. Bunny Rabbit, pull and through.'

      fill_in 'video[title]', with: 'How to tie your shoes.'
      fill_in 'video[description]', with: part1 + part2
      fill_in 'video[video_id]', with: 'J7ikFUlkP_k'
      click_on 'Create Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

      within(first('.video')) do
        expect(page).to have_content('How to tie your shoes.')
      end
    end
  end
end
