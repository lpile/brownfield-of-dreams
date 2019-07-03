# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user.github_token
      user_token = current_user.github_token
      github_api_service = GithubApiService.new(user_token)
      @repositories = github_api_service.repository_info[0..4].map do |result|
        Github::RepositoryApi.new(result)
      end

      @followers = github_api_service.follower_info.map do |result|
        Github::FollowerApi.new(result)
      end

      @followings = github_api_service.following_info.map do |result|
        Github::FollowingApi.new(result)
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
