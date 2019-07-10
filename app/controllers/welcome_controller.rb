# frozen_string_literal: true

# WelcomeController for landing page
class WelcomeController < ApplicationController
  def index
    @tutorials = if current_user
                   classroom_content
                 else
                   visitor_content
                 end
  end

  private

  def classroom_content
    if params[:tag]
      Tutorial.tagged_with(params[:tag]).paginate(page_params)
    else
      Tutorial.all.paginate(page_params)
    end
  end

  def visitor_content
    if params[:tag]
      Tutorial.visitor_content.tagged_with(params[:tag]).paginate(page_params)
    else
      Tutorial.visitor_content.paginate(page_params)
    end
  end

  def page_params
    { page: params[:page], per_page: 5 }
  end
end
