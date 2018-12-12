# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email               { Faker::Internet.email }
    password            { Faker::Internet.password }
    sequence(:username) { |n| "#{Faker::Internet.username}#{n}" }

    factory :user_with_avatar do
      avatar { File.new("#{Rails.root}/spec/support/test.jpg") }
    end
  end
end