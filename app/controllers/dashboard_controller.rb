require 'csv'

class DashboardController < ApplicationController
	include ActionView::Helpers::NumberHelper
	
	before_filter :authenticate_admin!, :get_transactions #, :get_statements
	layout "sidebar_layout"

	@@agent = Mechanize.new

	def index

		@percentage = ""#percentage
		@cash = get_cash
		
		download_statements
		@revenue = revenue
		@profit = profit
		@bsc = balanced_score_card

		render :layout => "application"
	end

	private

	def get_transactions(last_n_months=1)
		@transactions = Dashboard::Transaction.find(:all, :conditions => {:date => Date.today.prev_month(last_n_months)..Date.today})
	end

	def revenue
		revenue = 0
		
		@transactions.each do |transaction|
			if transaction.amount > 0
				revenue = revenue + transaction.amount
			end
		end

		return number_to_currency(revenue, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")
	end

	def profit
		profit = 0
		@transactions.each do |transaction|
			p number_to_currency(transaction.amount)
			if not (transaction.description.downcase.index('winstopname') || transaction.description.downcase.index('inkomsten') || transaction.description.downcase.index('winstdeling') )
				profit = profit + transaction.amount
			end
		end
		return number_to_currency(profit, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")

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

	def get_cash
		# agent = Mechanize.new
		page = @@agent.get("https://mijnzakelijk.ing.nl/internetbankieren/SesamLoginServlet")
		form = page.form_with :name => "login"
		username_field = form.fields.first.name
		password_field = form.fields.second.name
		remember_field = form.checkboxes.first.name

		form.field_with(:name => username_field).value = "ftk6p7h7"
		form.field_with(:name => password_field).value = "Andres314"

		results = @@agent.submit form

		urls = Array["https://mijnzakelijk.ing.nl/internetbankieren/jsp/IndexLogon.jsp",
					 "https://mijnzakelijk.ing.nl/internetbankieren/jsp/sesam_cockpit.jsp",
					 "https://mijnzakelijk.ing.nl/mpz/startframes.do",
					 "https://mijnzakelijk.ing.nl/mpz/startpagina.do",
					 "https://mijnzakelijk.ing.nl/mpz/startpaginarekeninginfo.do"]
		urls.each do |url|
			page = @@agent.get(url)
		end

		value = page.at("#giro_0").at("[@align='right']").content.to_s
		value = value.gsub(".","").gsub(",",".").to_d
		return number_to_currency(value, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")

	end

	def download_statements
		if Dashboard::Transaction.order(:date).last != nil
			last_downloaded_statement_date = Dashboard::Transaction.order(:date).last.date
		else
			last_downloaded_statement_date = Date.today.prev_year(5)
		end
		page = @@agent.get("https://mijnzakelijk.ing.nl/mpz/girordpl/downloadperiodeselecteren.do")
		form = page.form_with :name => "form1"
		from_date = form.field_with(:name => "datumvan").value = last_downloaded_statement_date.strftime("%d-%m-%Y")
		to_date = form.field_with(:name => "datumtot").value = Date.today.strftime("%d-%m-%Y")
		format = form.field_with(:name => "formaat").options.third.tick
		@@agent.submit form

		response = @@agent.get("https://mijnzakelijk.ing.nl/mpz/girordpl/download.do?datumvan=" + last_downloaded_statement_date.strftime("%d-%m-%Y") + "&datumtot=" + Date.today.strftime("%d-%m-%Y") + "&formaat=kommacsv")

		file = File.new("/tmp/bankstatement.csv", "w")
		file.write(response.content.to_s)
		file.close

 		import_csv(response.content.to_s)

	end

	def import_csv(csv)

		if csv.kind_of?(String)
			csv = CSV.parse(csv)
	  	elsif not csv.kind_of?(Array)
	  		raise "Not an Array or String."
	  	end

	 	csv[1...csv.length].each do |row|
	 		if not Dashboard::Transaction.where(:description => row[8], :date => Date.parse(row[0])).first
				if row[5].index "Af"
					amount = -(row[6].to_d.abs)
				else
					amount = row[6].to_d.abs
				end
	 			Dashboard::Transaction.create!(:date => Date.parse(row[0]), :name => row[1], :account => row[2], :contra_account => row[3], :code => row[4], :amount => amount, :transfer_type => row[7], :description => row[8])
	 		end
	 	end

	end

end