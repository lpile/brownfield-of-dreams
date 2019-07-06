# frozen_string_literal: true

class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom_content? && !current_user
      render file: 'public/404', status: 404
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
