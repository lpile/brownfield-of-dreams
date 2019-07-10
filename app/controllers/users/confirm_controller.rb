# frozen_string_literal: true

# User module
module Users
  # ConfirmController
  class ConfirmController < ApplicationController
    def create
      user = User.find_by_confirm_token(params[:token])
      if user
        user.validate_email
        user.save(validate: false)
        flash[:success] = 'Thank you! Your account is now activated.'
        redirect_to dashboard_path
      else
        flash[:error] = 'Sorry. User does not exist'
        redirect_to root_url
      end
    end
  end
end
