# frozen_string_literal: true

FactoryBot.define do
  factory :image, class: 'Image' do
    sequence :image_name  do |n|
      "image_#{n}"
    end

    picture     { File.new(Rails.root + 'spec/support/test.jpg') }

    association :category, factory: :category
    association :user, factory: :user

    factory :image_with_comments do
      after(:create) do |image|
        create_list(:comment, 3, image: image, user: image.user)
      end
    end

    factory :image_with_like do
      after(:create) do |image|
        create(:vote, :like, image: image, user: image.user)
      end
    end

    factory :image_with_dislike do
      after(:create) do |image|
        create(:vote, :dislike, image: image, user: image.user)
      end
    end
  end
end
