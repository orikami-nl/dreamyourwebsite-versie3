class CreateDashboardBillableHours < ActiveRecord::Migration
  def change
    create_table :dashboard_billable_hours do |t|
      t.datetime :datetime
      t.float :value

      t.timestamps
    end
  end
end
