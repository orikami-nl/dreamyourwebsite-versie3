class FixBankIdType < ActiveRecord::Migration
  def change
  	change_column :dashboard_bank_balances, :bank_id, :integer, :default => 0
  end
end
