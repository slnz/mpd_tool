# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid '65722234'
    provider 'facebook'
    email { Faker::Internet.email }
  end
end
