class CreateDashboardIncomingInvoices < ActiveRecord::Migration
  def change
    create_table :dashboard_incoming_invoices do |t|
      t.string :currency
      t.integer :invoice_id
      t.decimal :total_paid
      t.decimal :total_unpaid
      t.string :state
      t.date :date

      t.timestamps
    end
  end
end
