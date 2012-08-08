require 'csv'

class DashboardController < ApplicationController
	include ActionView::Helpers::NumberHelper
	
	before_filter :authenticate_admin!
	layout "sidebar_layout"

	@@agent = Mechanize.new

	def index

		@bank = Dashboard::Bank.first
		balanced_score_card
		@total_unpaid_invoices = total_unpaid_invoices
		@total_unpaid_incoming_invoices = total_unpaid_incoming_invoices
		@balans = @total_unpaid_invoices - @total_unpaid_incoming_invoices
		@billable_hours = Dashboard::BillableHours.find(:all).sort_by(&:datetime).last.value
		@billable_hours_array = billable_hours_array

		render :layout => "application"
	end

	def total_unpaid_invoices
		total = 0
		Dashboard::Invoice.find(:all).each do |invoice|
			# if invoice.state == "open"
				total = total + invoice["total_unpaid"].to_i
			# end
		end
		return total
	end

	def total_unpaid_incoming_invoices
		total = 0
		Dashboard::IncomingInvoice.find(:all).each do |invoice|
			if invoice.state == "open"
				total = total + invoice["total_unpaid"].to_i
			end
		end
		return total
	end

	def billable_hours_array
		billable_hours = Array.new
		Dashboard::BillableHours.find(:all).sort_by(&:datetime).each do |bh|
			billable_hours << bh
		end
	end


	private

	# def get_statements

	# 	@transfers = Array.new;

	# 	drive = GoogleDrive.login("andres@dreamyourweb.nl","ilmul4t3!")

	# 	drive.collection_by_title("dreamyourweb").subcollection_by_title("dashboard").subcollection_by_title("MT940").files.each do |file|
	# 		file.download_to_file("/tmp/bankstatement.940")
	# 		@transfers.concat(MT940::Base.transactions("/tmp/bankstatement.940"))
	# 	end

	# 	@transfers.sort! { |a,b| a.date <=> b.date}
	# end


	def balanced_score_card
		total = 0
		total_weighted = 0
		response = Solve360::Bsc.find("")
		opportunities = response.attributes[:opportunities]
		opportunities.each do |opportunity|	
			if (opportunity.closingdate != "") && Date.parse(opportunity.closingdate) <=> Date.today.next_month
				total = total + opportunity.attributes[:valueunit].to_i
				total_weighted = total_weighted + opportunity.attributes[:valueunit].to_i * opportunity.attributes[:probability].to_i/100
			end
		end

		@bsc_total = total
		@bsc_probable = total_weighted

	end


end