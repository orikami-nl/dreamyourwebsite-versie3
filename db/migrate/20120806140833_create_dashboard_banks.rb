class CreateDashboardBanks < ActiveRecord::Migration
  def change
    create_table :dashboard_banks do |t|
      t.string :name
      t.datetime :last_update
      t.decimal :current_balance

      t.timestamps
    end
  end
end
