# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    association :category, factory: :category
    association :user, factory: :user
  end
end