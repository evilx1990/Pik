class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :follows, dependent: :destroy
  belongs_to :user

  mount_uploader :preview, PreviewUploader

  validates :name, length: { minimum: 3, maximum: 15 }
  validates_uniqueness_of :name, case_sensitive: false

  extend FriendlyId
  friendly_id :name, use: :slugged
end
