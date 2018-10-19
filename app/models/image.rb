class Image < ApplicationRecord
  acts_as_votable
  mount_uploader :picture, ImageUploader
  paginates_per 5

  validates :picture, presence: true, file_size: { less_than: 50.megabytes }

  has_many :comments, dependent: :destroy
  belongs_to :category, counter_cache: :count
  belongs_to :user
end
