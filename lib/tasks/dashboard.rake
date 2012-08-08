namespace :dashboard do

  namespace :import do

    desc "Import invoices from Moneybird"
    task :invoices => :environment do
      invoices = Moneybird::Invoice.find(:all)
      ActiveRecord::Base.transaction do
        invoices.each do |invoice|
          Dashboard::Invoice.where(:id => invoice.id).first_or_create(:currency => invoice.currency, :state => invoice.state, :total_paid => invoice.total_paid, :total_price_excl_tax => invoice.total_price_excl_tax, :total_price_incl_tax => invoice.total_price_incl_tax, :total_unpaid => invoice.total_unpaid)
        end
      end
      p "Invoices imported"
    end

    desc "Import incoming invoices from Moneybird"
    task :incoming_invoices => :environment do
      invoices = Moneybird::IncomingInvoice.find(:all)
      ActiveRecord::Base.transaction do
        invoices.each do |invoice|
          Dashboard::IncomingInvoice.where(:id => invoice.id).first_or_create(:currency => invoice.currency, :state => invoice.state, :total_paid => invoice.total_paid, :total_unpaid => invoice.total_unpaid, :date => invoice.invoice_date)
        end
      end
      p "Incoming invoices imported"
    end

    desc "Import bank balance and transactions from ING"
    task :bank_data => :environment do
      Dashboard::Bank.first.update_data
      p "Bank data imported"
    end

    desc "Import billabe hours from Toggl"
    task :billable_hours => :environment do
      toggl = Toggl.new
      users = toggl.get_users
      outside_project_names = ["General stuff", "No project", "Zelfstudie", "DYWorld", "DreamYourWeb website", "Netwerken", "Representatief"]
      
      duration = 0
      duration_outside = 0
      users.each do |user|
        api_token = user["api_token"]
        data = toggl.get_time_entries(api_token, {}, Time.now.months_ago(1).at_beginning_of_month, Time.now.months_ago(1).at_end_of_month)
        data.each do |entry|
          duration += entry["duration"]
          if entry["project"].nil? || outside_project_names.include?(entry["project"]["name"])
            duration_outside += entry["duration"]
          end
        end     
      end     
      Dashboard::BillableHours.create!(:value => (duration.to_f - duration_outside.to_f)/duration.to_f, :datetime => DateTime.now)
      p "Billabe hours imported from Toggl"
    end

    task :all => [:invoices, :incoming_invoices, :bank_data, :billable_hours]

  end

  desc "Import everything"
  task :import => 'import:all'

end