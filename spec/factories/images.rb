# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    image_name  { 'image_name' }
    picture     { File.open('spec/support/test.jpg') }

    association :category, factory: :category
    association :user, factory: :user

    factory :image_with_comments do
      transient do
        comments_count { 3 }
      end

      after(:create) do |image|
        create_list(:comment, evaluator.comments_count, image: image, user: image.user)
      end
    end

    factory :image_with_votes do
      transient do
        votes_count { 3 }
      end

      after(:create) do |image|
        create_list(:likes, evaluator.votes_count, image: image, user: image.user)
        create_list(:dislikes, evaluator.votes_count, image: image, user: image.user)
      end
    end
  end
end
