class Moneybird::Invoice < ActiveResource::Base
	self.site = "https://dreamyourweb.moneybird.nl"
	self.user = "andres@dreamyourweb.nl"
	self.password = "dreamyourmoney"
end
