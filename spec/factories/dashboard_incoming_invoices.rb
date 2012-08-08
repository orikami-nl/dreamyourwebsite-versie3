# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard_incoming_invoice, :class => 'Dashboard::IncomingInvoice' do
    currency "MyString"
    invoice_id 1
    total_paid "9.99"
    total_unpaid "9.99"
    state "MyString"
    date "2012-08-08"
  end
end
