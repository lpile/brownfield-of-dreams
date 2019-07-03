# frozen_string_literal: true

require 'rails_helper'

describe GithubApiService do
  let(:user) { create(:user, github_token: ENV['GITHUB_TOKEN']) }
  let(:github_api_service) { GithubApiService.new(user.github_token) }

  it 'exists' do
    expect(github_api_service).to be_a GithubApiService
  end

  context '#repositories_info' do
    it 'returns repository data for user' do
      VCR.use_cassette('services/github_repository_data') do
        repository_data = github_api_service.repository_info
        repository = repository_data.first

        expect(repository_data).to be_a Array
        expect(repository_data.count).to eq(30)
        expect(repository).to have_key(:name)
        expect(repository).to have_key(:html_url)
      end
    end
  end

  context '#follower_info' do
    it 'returns follower data for user' do
      VCR.use_cassette('services/github_follower_data') do
        follower_data = github_api_service.follower_info
        follower = follower_data.first

        expect(follower_data).to be_a Array
        expect(follower_data.count).to eq(6)
        expect(follower).to have_key(:login)
        expect(follower).to have_key(:html_url)
      end
    end
  end

  context '#following_info' do
    it 'returns following data for user' do
      VCR.use_cassette('services/github_following_data') do
        following_data = github_api_service.following_info
        following = following_data.first

        expect(following_data).to be_a Array
        expect(following_data.count).to eq(2)
        expect(following).to have_key(:login)
        expect(following).to have_key(:html_url)
      end
    end
  end
end
