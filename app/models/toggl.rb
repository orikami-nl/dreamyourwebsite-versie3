require "rubygems"
require "httparty"
#require "chronic_duration"
require "multi_json"

class Toggl
  include HTTParty
  base_uri "https://www.toggl.com"
  format :json
  headers  "Content-Type" => "application/json"

	def get_users(query={})
		auth = {:username => ENV["TOGGL_API_TOKEN"], :password => "api_token"}
    response = self.class.get("/api/v6/workspaces/138404/users.json", :basic_auth => auth, :query => query)
		response['data']
	end

	def get_time_entries(token, query={}, start_date=Time.now.months_ago(1), end_date=Time.now)
		auth = {:username =>  ENV["TOGGL_API_TOKEN"], :password => "api_token"}
    response = self.class.get("/api/v6/time_entries.json?start_date=#{start_date.iso8601}&end_date=#{end_date.iso8601}", :basic_auth => auth, :query => query)
		response['data']
	end
end
