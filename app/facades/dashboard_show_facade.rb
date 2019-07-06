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
    github_api_service.following_info.map do |result|
      Github::FollowingApi.new(result)
    end
  end

  private
  attr_reader :github_token

  def github_api_service
    GithubApiService.new(@github_token)
  end
end