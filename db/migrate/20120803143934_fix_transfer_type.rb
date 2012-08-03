class FixTransferType < ActiveRecord::Migration
  def change
  	rename_column :dashboard_transactions, :type, :transfer_type
  end
end
