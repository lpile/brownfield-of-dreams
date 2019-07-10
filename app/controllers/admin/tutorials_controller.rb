# frozen_string_literal: true

# Admin module
module Admin
  # TutorialsController
  class TutorialsController < Admin::BaseController
    def edit
      @tutorial = Tutorial.find(params[:id])
    end

    def create
      tutorial = Tutorial.new(new_params)
      tutorial.save

      redirect_to tutorial_path(tutorial)
    end

    def new
      @tutorial = Tutorial.new
    end

    def update
      tutorial = Tutorial.find(params[:id])
      flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
      redirect_to edit_admin_tutorial_path(tutorial)
    end

    private

    def tutorial_params
      params.require(:tutorial).permit(:tag_list)
    end

    def new_params
      params.require(:tutorial).permit(:title, :description, :thumbnail)
    end
  end
end
