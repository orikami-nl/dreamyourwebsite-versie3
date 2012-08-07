class BalancesDateTimeToDate < ActiveRecord::Migration
  def change
  	rename_column :dashboard_bank_balances, :datetime, :date
  	change_column :dashboard_bank_balances, :date, :date
  end
end
