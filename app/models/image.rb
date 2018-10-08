class Image < ApplicationRecord
  mount_uploader :path, ImageUploader

  has_many :comments
  belongs_to :category
  belongs_to :user
end
