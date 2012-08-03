require 'csv'

class Dashboard::Transaction < ActiveRecord::Base
  attr_accessible :account, :amount, :code, :contra_account, :date, :description, :name, :transfer_type
end
