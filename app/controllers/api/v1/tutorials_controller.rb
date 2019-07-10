# frozen_string_literal: true

# Api module
module Api
  # V1 module
  module V1
    # TutorialsController
    class TutorialsController < ApplicationController
      def index
        render json: Tutorial.all
      end

      def show
        render json: Tutorial.find(params[:id])
      end
    end
  end
end
