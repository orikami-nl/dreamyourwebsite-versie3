# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard_invoice, :class => 'Dashboard::Invoice' do
    currency "MyString"
    invoice_id 1
    total_paid "9.99"
    total_price_excl_tax "9.99"
    total_price_incl_tax "9.99"
    total_unpaid "9.99"
    state "MyString"
  end
end
