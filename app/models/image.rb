class Image < ApplicationRecord
  acts_as_votable
  mount_uploader :path, ImageUploader

  validates :path, presence: true, file_size: { less_than: 50.megabytes }

  has_many :comments
  belongs_to :category
  belongs_to :user
end
