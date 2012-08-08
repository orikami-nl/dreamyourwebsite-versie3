module DashboardHelper

	def number_to_euro(number)
		number_to_currency(number, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")
	end

	def data_to_js(data)
		str = "["
		data.each do |d|
			str = str + "{ x: " + d.datetime.strftime("%s") + ", y: " + d.value.to_s + "}"
			if d != data.last
				str = str + ","
			end
		end
		str = str + "]"
	end

end
