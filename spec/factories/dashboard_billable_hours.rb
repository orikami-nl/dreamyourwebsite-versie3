# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard_billable_hour, :class => 'Dashboard::BillableHours' do
    datetime "2012-08-08 16:07:00"
    value 1.5
  end
end
