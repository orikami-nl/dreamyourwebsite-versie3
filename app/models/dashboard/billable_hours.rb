class Dashboard::BillableHours < ActiveRecord::Base
  attr_accessible :datetime, :value
end
