class DashboardController < ApplicationController

	before_filter :authenticate_admin!

  def index
		toggl_response = Toggl.new.get_paid_project_hours(ENV['TOGGL_API_TOKEN'], ENV['TOGGL_PASSWORD'])
  end
end
