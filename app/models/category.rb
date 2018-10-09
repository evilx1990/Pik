class Category < ApplicationRecord
  validates :name, presence: true

  has_many :images, dependent: :destroy
  belongs_to :user
end
