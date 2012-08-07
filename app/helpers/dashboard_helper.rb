module DashboardHelper

	def number_to_euro(number)
		number_to_currency(number, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")
	end

	def balances_to_js_data(data)
		str = "["
		data.each do |balance|
			str = str + "{ x: " + balance.datetime.strftime("%s") + ", y: " + balance.value.to_s + "}"
			if balance != data.last
				str = str + ","
			end
		end
		str = str + "]"
	end

end
