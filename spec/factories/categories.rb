# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: 'Category' do
    name { 'CategoryName' }

    association :user, factory: :user

    factory :category_with_images do
      after(:create) do |category|
        create_list(:image, 3, category: category)
      end
    end

    factory :category_with_follows do
      after(:create) do |category|
        create_list(:follow, 3, followable: category)
      end
    end

    factory :category_with_follow do
      after(:create) do |category|
        create(:follow, followable: category, follower: category.user)
      end
    end

    factory :category_with_img_cmnt_fllw do
      after(:create) do |category|
        create_list(:follow, 3, followable: category)
        create_list(:image_with_comments, 3, category: category)
      end
    end
  end
end