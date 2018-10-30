class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user

  after_create :increment_counter_cache
  after_destroy :decrement_counter_cache

  validates :body, presence: true

  private

  def increment_counter_cache
    Category.increment_counter('count', self.image.category.id)
  end

  def decrement_counter_cache
    Category.decrement_counter('count', self.image.category.id)
  end
end
