# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor' do
  before :each do
    @tutorial1 = create(:tutorial)
    @tutorial2 = create(:tutorial, classroom: true)

    @video1, @video2 = create_list(:video, 2, tutorial_id: @tutorial1.id)
    @video3, @video4 = create_list(:video, 2, tutorial_id: @tutorial2.id)
  end

  describe 'on the home page' do
    it 'can see a list of tutorials but not classroom content tutorials' do
      visit root_path

      expect(page).to have_css('.tutorial', count: 1)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(@tutorial1.title)
        expect(page).to have_content(@tutorial1.description)
      end
    end
  end

  context 'edge cases' do
    it 'cannot visit classroom content tutorial show page' do
      visit tutorial_path(@tutorial2)

      expect(current_path).to eq(tutorial_path(@tutorial2))
      expect(page.status_code).to eq(404)
    end
  end
end
