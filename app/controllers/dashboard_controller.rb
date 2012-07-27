class DashboardController < ApplicationController
	include ActionView::Helpers::NumberHelper
	
	before_filter :authenticate_admin!, :get_statements
	layout "sidebar_layout"

	def index

		# @percentage = percentage
		@balance = balance
		@revenue = revenue
		@bsc = balanced_score_card

		render :layout => "application"
	end

	private

	def revenue(last_n_months=1)
		revenue = 0
		
		transfers_last_month = @transfers.select {|transfer| (transfer.date <=> Date.today.prev_month(2)) == 1}
		transfers_last_month_in = transfers_last_month.select {|transfer| transfer.amount > 0}

		transfers_last_month_in.each do |transfer|
			revenue = revenue + transfer.amount
		end

		return  number_to_currency(revenue, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")

	end

	def balance
		drive = GoogleDrive.login("andres@dreamyourweb.nl","ilmul4t3!")
		balance = 0

		@transfers.each do |transfer|
			balance = balance + transfer.amount
		end

		return number_to_currency(balance, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")
	end

	def get_statements

		@transfers = Array.new;

		drive = GoogleDrive.login("andres@dreamyourweb.nl","ilmul4t3!")

		drive.collection_by_title("dreamyourweb").subcollection_by_title("dashboard").subcollection_by_title("MT940").files.each do |file|
			file.download_to_file("/tmp/bankstatement.940")
			@transfers.concat(MT940::Base.transactions("/tmp/bankstatement.940"))
		end

		@transfers.sort! { |a,b| a.date <=> b.date}
	end

	def percentage
		toggl = Toggl.new
		users = toggl.get_users
		outside_project_names = ["General stuff", "No project", "Zelfstudie", "DYWorld", "DreamYourWeb website", "Netwerken", "Representatief"]
		
		duration = 0
		duration_outside = 0
		users.each do |user|
			api_token = user["api_token"]
			data = toggl.get_time_entries(api_token, {}, Time.now.months_ago(1).at_beginning_of_month, Time.now.months_ago(1).at_end_of_month)
			data.each do |entry|
				duration += entry["duration"]
				if entry["project"].nil? || outside_project_names.include?(entry["project"]["name"])
					duration_outside += entry["duration"]
				end
			end			
		end			
		return number_to_percentage((duration.to_f - duration_outside.to_f)/duration.to_f*100, :precision => 1)
	end

	def balanced_score_card
		total = 0
		total_weighted = 0
		response = Solve360::Bsc.find("",{:start => Date.today, :end => Date.today.next_month})
		opportunities = response.attributes[:opportunities]
		opportunities.each do |opportunity|
			total = total + opportunity.attributes[:valueunit].to_i
			total_weighted = total_weighted + opportunity.attributes[:valueunit].to_i * opportunity.attributes[:probability].to_i/100
		end

		return (number_to_currency(total, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;") + " " + number_to_currency(total_weighted, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")).html_safe

	end

end
