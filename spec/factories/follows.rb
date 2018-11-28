# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    followable_type { 'Category' }
    follower_type   { 'User' }

    association :followable, factory: :category
    association :follower, factory: :user
  end
end