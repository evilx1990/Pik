class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :follows, dependent: :destroy
  belongs_to :user
  belongs_to :image, optional: true

  validates :name, length: { minimum: 3, maximum: 15 }

  extend FriendlyId
  friendly_id :name, use: :slugged
end
