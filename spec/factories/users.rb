# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email               { Faker::Internet.email }
    password            { Faker::Internet.password }
    sequence(:username) { |n| "#{Faker::Internet.username}#{n}" }
  end
end