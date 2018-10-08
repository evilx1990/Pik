class Category < ApplicationRecord
  validates :name, presence: true

  has_many :images
  belongs_to :user
end
