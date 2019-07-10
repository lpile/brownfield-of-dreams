# frozen_string_literal: true

# Github module
module Github
  # FollowerApi poro
  class FollowerApi
    attr_reader :login,
                :html_url

    def initialize(attributes = {})
      @login = attributes[:login]
      @html_url = attributes[:html_url]
    end
  end
end
