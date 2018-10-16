class Category < ApplicationRecord
  acts_as_followable
  validates :name, presence: true

  has_many :images, dependent: :destroy
  belongs_to :user
end
