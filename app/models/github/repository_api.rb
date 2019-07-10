# frozen_string_literal: true

# Github module
module Github
  # RepositoryApi poro
  class RepositoryApi
    attr_reader :name,
                :html_url

    def initialize(attributes = {})
      @name = attributes[:name]
      @html_url = attributes[:html_url]
    end
  end
end
