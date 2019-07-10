# frozen_string_literal: true

# Admin module
module Admin
  # Api module
  module Api
    # V1 module
    module V1
      # TutorialSequencerController
      class TutorialSequencerController < Admin::Api::V1::BaseController
        def update
          tutorial = Tutorial.find(params[:tutorial_id])
          TutorialSequencer.new(tutorial, ordered_video_ids).run!

          render json: tutorial
        end

        private

        def ordered_video_ids
          params[:tutorial_sequencer][:_json]
        end
      end
    end
  end
end
