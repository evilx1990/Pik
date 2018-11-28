# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    action { 'test' }
    url { 'www.example.com' }

    association :user, factory: :user
  end
end
