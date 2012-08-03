class CreateDashboardTransactions < ActiveRecord::Migration
  def change
    create_table :dashboard_transactions do |t|
      t.date :date
      t.string :name
      t.integer :account
      t.integer :contra_account
      t.string :code
      t.decimal :amount
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
