# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    flag { nil }

    association :user, factory: :user
    association :image, factory: :image

    trait :like do
      flag { true }
    end

    trait :dislike do
      flag { false }
    end
  end
end