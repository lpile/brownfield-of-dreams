# frozen_string_literal: true

# User module
module Users
  # InviteController
  class InviteController < ApplicationController
    def create
      invitee = service.invitee_email(params[:github_handle])
      if invitee[:email]
        send_invite_email(invitee)
      else
        flash[:error] = invalid_email_message1 + invalid_email_message2
      end
      redirect_to dashboard_path
    end

    private

    def send_invite_email(invitee)
      UserMailer.invite_by_email(current_user, invitee).deliver_now
      flash[:success] = 'Successfully sent invite!'
    end

    def service
      GithubApiService.new(current_user.github_token)
    end

    def invalid_email_message1
      "The Github user you selected doesn't have "
    end

    def invalid_email_message2
      'an email address associated with their account.'
    end
  end
end
