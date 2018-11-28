# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: 'Category' do
    name { 'CategoryName' }

    association :user, factory: :user

    factory :category_with_images do
      transient do
        images_count { 3 }
      end

      after(:create) do |category|
        create_list(:image, evaluator.images_count, category: category, user: category.user)
      end
    end

    factory :category_with_follows do
      transient do
        follows_count { 3 }
      end

      after(:create) do |category|
        create_list(:follow,
                    evaluator.follows_count,
                    category: category,
                    user: category.user)
      end
    end
  end
end