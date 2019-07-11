# frozen_string_literal: true

# Github module
module Github
  # FollowingApi poro
  class FollowingApi
    attr_reader :login,
                :html_url,
                :possible_friend

    def initialize(attributes = {}, possible_friend_user_ids)
      @login = attributes[:login]
      @html_url = attributes[:html_url]
      @possible_friend = check_friend(attributes[:id], possible_friend_user_ids)
    end

    def check_friend(id, user_ids)
      user_ids.include?(id)
    end
  end
end
