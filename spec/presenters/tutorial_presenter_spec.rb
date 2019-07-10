# frozen_string_literal: true

require 'rails_helper'
describe TutorialFacade do
  describe 'instance methods' do
    before :each do
      @tutorial = create(:tutorial)
      @video1 = create(:video, tutorial_id: @tutorial.id, position: 1)
      @video2 = create(:video, tutorial_id: @tutorial.id, position: 2)
      @video3 = create(:video, tutorial_id: @tutorial.id, position: 3)
    end

    it 'can find the current video' do
      presenter = TutorialFacade.new(@tutorial, @video2.id)

      expect(presenter.current_video.id).to eq(@video2.id)
    end

    it 'uses first video if video id not present' do
      presenter = TutorialFacade.new(@tutorial)

      expect(presenter.current_video.id).to eq(@video1.id)
    end

    context '#next_video' do
      it 'can find the next video' do
        presenter = TutorialFacade.new(@tutorial, @video1.id)

        expect(presenter.next_video).to eq(@video2)
      end

      it 'returns the last video if the current video is the last in list' do
        presenter = TutorialFacade.new(@tutorial, @video3.id)

        expect(presenter.next_video).to eq(@video3)
      end
    end
  end
end
