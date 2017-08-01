# frozen_string_literal: true

FactoryGirl.define do
  factory :deposit do
    amount '9.99'
    first_name 'MyString'
    last_name 'MyString'
    address_line_1 'MyString'
    address_line_2 'MyString'
    city 'MyString'
    postcode 'MyString'
    status 1
    giving_method 1
  end
end
