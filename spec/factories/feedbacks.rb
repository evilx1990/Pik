# frozen_string_literal: true

FactoryBot.define do
  factory :feedback do
    email_author  { Faker::Internet.email }
    name          { Faker::Internet.name }
    feedback      { 'Some text' }
  end
end
