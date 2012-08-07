class FixDateTimeAgain < ActiveRecord::Migration
  def change
  	rename_column :dashboard_bank_balances, :date, :datetime
  	change_column :dashboard_bank_balances, :datetime, :datetime
  end
end
