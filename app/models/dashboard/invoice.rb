class Dashboard::Invoice < ActiveRecord::Base
  attr_accessible :currency, :state, :total_paid, :total_price_excl_tax, :total_price_incl_tax, :total_unpaid

end
