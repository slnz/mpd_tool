# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :donation do
    global_id 1
    contact_id 1
    designation_id 1
    payment_method 'MyString'
    display_date Time.zone.now
    amount '9.99'
  end
end
