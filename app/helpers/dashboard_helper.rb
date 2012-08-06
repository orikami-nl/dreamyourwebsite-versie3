module DashboardHelper

	def number_to_euro(number)
		number_to_currency(number, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")
	end

end
