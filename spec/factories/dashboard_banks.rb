# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard_bank, :class => 'Dashboard::Bank' do
    name "MyString"
    last_update "2012-08-06 16:08:33"
    current_balance "9.99"
  end
end
