# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    flag { true }
  end

  factory :dislike do
    flag { false }
  end
end