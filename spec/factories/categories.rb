# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: 'Category' do
    name { 'CategoryName' }

    association :user, factory: :user

    factory :category_with_images do
      after(:create) do |category|
        create_list(:image, 3, category: category, user: category.user)
      end
    end

    factory :category_with_follows do
      after(:create) do |category|
        create_list(:follow, 3, followable: category, follower: category.user)
      end
    end
  end
end