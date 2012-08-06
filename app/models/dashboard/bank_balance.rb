class Dashboard::BankBalance < ActiveRecord::Base
  attr_accessible :bank_id, :datetime, :value
  belongs_to :bank
end
