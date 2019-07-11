# frozen_string_literal: true

# DashboardShowFacade
class DashboardShowFacade
  attr_reader :bookmarked_videos

  def initialize(current_user)
    @github_token = current_user.github_token
    @bookmarked_videos = current_user.bookmarked_videos
  end

  def repositories
    github_api_service.repository_info[0..4].map do |result|
      Github::RepositoryApi.new(result)
    end
  end

  def followers
    github_api_service.follower_info.map do |result|
      Github::FollowerApi.new(result)
    end
  end

  def followings
    results = github_api_service.following_info
    results.map do |result|
      Github::FollowingApi.new(result, get_friends_user_ids(results))
    end
  end

  private

  attr_reader :github_token

  def get_friends_user_ids(array)
    @ids ||= User.where(github_id: array.map{|hash| hash[:id]}).pluck(:github_id)
  end

  def github_api_service
    GithubApiService.new(@github_token)
  end
end
