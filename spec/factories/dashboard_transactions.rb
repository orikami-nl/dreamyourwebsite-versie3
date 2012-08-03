# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard_transaction, :class => 'Dashboard::Transaction' do
    date "2012-08-03"
    name "MyString"
    account 1
    contra_account 1
    code "MyString"
    amount "9.99"
    type ""
    description "MyText"
  end
end
