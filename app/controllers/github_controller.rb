# frozen_string_literal: true

# GithubController to authorize omniauth
class GithubController < ApplicationController
  def new
    auth = request.env['omniauth.auth']
    token = auth['credentials']['token']
    user_info = GithubApiService.new(token).get_user_info
    id = user_info[:id]
    handle = user_info[:login]
    current_user.update(github_token: token, github_id: id, github_handle: handle)

    redirect_to dashboard_path
  end
end
