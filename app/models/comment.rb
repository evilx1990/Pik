class Comment < ApplicationRecord
  belongs_to :image, counter_cache: :comments_count
  belongs_to :user

  validates :body, presence: true
end
