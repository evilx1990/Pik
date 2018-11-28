# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { 'Some text!' }

    association :user, factory: :user
    association :image, factory: :image
  end
end