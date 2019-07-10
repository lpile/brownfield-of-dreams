# frozen_string_literal: true

# Admin module
module Admin
  # DashboardController
  class DashboardController < Admin::BaseController
    def show
      @facade = AdminDashboardFacade.new
    end
  end
end
