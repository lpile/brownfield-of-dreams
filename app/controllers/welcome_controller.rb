# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if current_user
      classroom_content
    else
      visitor_content
    end
  end

  private

  def classroom_content
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end

  def visitor_content
    if params[:tag]
      @tutorials = Tutorial.visitor_content.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.visitor_content.paginate(page: params[:page], per_page: 5)
    end
  end
end
