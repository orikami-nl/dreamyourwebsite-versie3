class CreateDashboardInvoices < ActiveRecord::Migration
  def change
    create_table :dashboard_invoices do |t|
      t.string :currency
      t.decimal :total_paid
      t.decimal :total_price_excl_tax
      t.decimal :total_price_incl_tax
      t.decimal :total_unpaid
      t.string :state

      t.timestamps
    end
  end
end
