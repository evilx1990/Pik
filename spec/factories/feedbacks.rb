# frozen_string_literal: true

FactoryBot.define do
  factory :feedback do
    email_author  { Faker::Internet.email }
    name          { Faker::Internet.name }
    feedback      { Faker::String.random[1..20]}
  end
end
