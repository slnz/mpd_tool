FactoryGirl.define do
  factory :contact do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    designation_code 1324
    code 2345
  end
end
