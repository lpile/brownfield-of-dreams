
class GithubController < ApplicationController
  def new
    auth = request.env["omniauth.auth"]
    token = auth["credentials"]["token"]
    current_user.update(github_token: token)

    redirect_to dashboard_path
  end
end
