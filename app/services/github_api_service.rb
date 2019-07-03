# frozen_string_literal: true

class GithubApiService
  def initialize(token)
    @token = token
  end

  def repository_info
    get_json('/user/repos')
  end

  def follower_info
    get_json('/user/followers')
  end

  def following_info
    get_json('/user/following')
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = "token #{@token}"
    end
  end
end
