class Dashboard::IncomingInvoice < ActiveRecord::Base
  attr_accessible :currency, :date, :invoice_id, :state, :total_paid, :total_unpaid
end
