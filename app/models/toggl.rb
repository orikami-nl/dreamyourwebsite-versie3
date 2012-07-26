require "rubygems"
require "httparty"
#require "chronic_duration"
require "multi_json"

class Toggl
  include HTTParty
  base_uri "https://www.toggl.com"
  format :json
  headers  "Content-Type" => "application/json"

	def initialize(token, password)
		@auth = {:username => token, :password => password}
	end

	def get_paid_project_hours(data={})
    response = self.class.get("/api/v6/me.json", :basic_auth => @auth, :query => data)
    response['data'].nil? ? response : response['data']		
	end

	def get_unpaid_project_hours(data={})
    response = self.class.get("/api/v6/me.json", :basic_auth => @auth, :query => data)
    response['data'].nil? ? response : response['data']		
	end
end
