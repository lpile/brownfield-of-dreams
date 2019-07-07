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

  def update
    tutorial = Tutorial.find(params[:id])
    tutorial.update(classroom: params["tutorial"]["classroom"])

    redirect_to edit_admin_tutorial_path(tutorial)
  end
end
