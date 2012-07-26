class DashboardController < ApplicationController

	before_filter :authenticate_admin!

  def index
		@toggl = Toggl.new(ENV['TOGGL_API_TOKEN'], "api_token")
		@users = @toggl.get_users
		@outside_project_names = ["General stuff", "No project", "Zelfstudie", "DYWorld", "DreamYourWeb website", "Netwerken", "Representatief"]
		
		duration = 0
		duration_outside = 0
		@users.each do |user|
			api_token = user["api_token"]
			data = @toggl.get_time_entries(api_token, {}, Time.now.months_ago(1), Time.now)
			data.each do |entry|
				duration += entry["duration"]
				if entry["project"].nil? || @outside_project_names.include?(entry["project"]["name"])
					duration_outside += entry["duration"]
				end
			end			
		end			
		@percentage = ((duration.to_f - duration_outside.to_f)/duration.to_f*100).round
  end
end
