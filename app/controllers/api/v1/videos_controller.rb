# frozen_string_literal: true

# Api module
module Api
  # V1 module
  module V1
    # VideosController
    class VideosController < ApplicationController
      def show
        render json: Video.find(params[:id])
      end
    end
  end
end
