class AddBankIdToDashboardTransactions < ActiveRecord::Migration
  def change
  	add_column :dashboard_transactions, :bank_id, :integer
  end
end
