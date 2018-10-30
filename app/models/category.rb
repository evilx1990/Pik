class Category < ApplicationRecord
  acts_as_followable

  validates :name, length: { minimum: 3, maximum: 15 }

  has_many :images, dependent: :destroy, counter_cache: true
  has_many :comments, through: :images
  belongs_to :user
  belongs_to :image, optional: true
end
