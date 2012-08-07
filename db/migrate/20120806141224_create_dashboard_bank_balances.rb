class CreateDashboardBankBalances < ActiveRecord::Migration
  def change
    create_table :dashboard_bank_balances do |t|
      t.integer :bank_id
      t.datetime :datetime
      t.decimal :value

      t.timestamps
    end
  end
end
