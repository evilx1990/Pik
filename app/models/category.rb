class Category < ApplicationRecord
  acts_as_followable
  validates :name, length: { minimum: 3}

  has_many :images, dependent: :destroy
  belongs_to :user
end
