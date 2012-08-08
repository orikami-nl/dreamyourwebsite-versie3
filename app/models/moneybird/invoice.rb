class Moneybird::Invoice < ActiveResource::Base
	self.site = "https://dreamyourweb.moneybird.nl"
	self.user = "andres@dreamyourweb.nl"
	self.password = "dreamyourmoney"

	def self.filter(condition="all")
		return self.get("filter/"+condition.to_s)
	end
end
