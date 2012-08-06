# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard_bank_balance, :class => 'Dashboard::BankBalance' do
    bank_id "MyString"
    datetime "2012-08-06 16:12:25"
    value "9.99"
  end
end
