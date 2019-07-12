# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  before :each do
    @tutorial = create(:tutorial)
    @video1 = create(:video, tutorial_id: @tutorial.id)
    @user = create(:user)
  end

  it 'can add videos to their bookmarks' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit tutorial_path(@tutorial)

    expect do
      click_on 'Bookmark'
    end.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it "can't add the same bookmark more than once" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit tutorial_path(@tutorial)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on 'Bookmark'
    expect(page).to have_content('Already in your bookmarks')
  end

  it 'shows a list of all bookmarked videos' do
    t1 = create(:tutorial, title: 'How to Tie Your Shoes vol1')
    v1 = create(:video, title: 'The Bunny Ears Technique vol1', tutorial: t1)
    t2 = create(:tutorial, title: 'How to Tie Your Shoes vol2')
    v2 = create(:video, title: 'The Bunny Ears Technique vol2', tutorial: t2)
    t3 = create(:tutorial, title: 'How to Tie Your Shoes vol3')
    v3 = create(:video, title: 'The Bunny Ears Technique vol3', tutorial: t3)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(t1)

    expect do
      click_on 'Bookmark'
    end.to change { UserVideo.count }.by(1)

    visit tutorial_path(t3)

    expect do
      click_on 'Bookmark'
    end.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')

    visit dashboard_path

    within '.bookmark' do
      expect(page).to have_content(v1.title)
      expect(page).to have_content(v1.tutorial.title)
      expect(page).to have_content(v3.title)
      expect(page).to have_content(v3.tutorial.title)
      expect(page).to have_no_content(v2.title)
      expect(page).to have_no_content(v2.tutorial.title)
    end
  end
end
