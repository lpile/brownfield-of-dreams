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
    @tutorials = if params[:tag]
                   Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 end
  end

  def visitor_content
    @tutorials = if params[:tag]
                   Tutorial.visitor_content.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.visitor_content.paginate(page: params[:page], per_page: 5)
                 end
  end
end
