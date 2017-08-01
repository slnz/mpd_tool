# frozen_string_literal: true

FactoryGirl.define do
  factory :campus do
    name { Faker::Name.name }
  end
end
