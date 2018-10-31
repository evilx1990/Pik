class Image < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :votes, counter_cache: true, dependent: :destroy
  belongs_to :category, counter_cache: :count
  belongs_to :user

  validates :picture, presence: true, file_size: { less_than: 50.megabytes }
  validates :image_name, presence: true, length: { minimum: 3, maximum: 15 }

  extend FriendlyId
  friendly_id :image_name, use: :slugged

  mount_uploader :picture, ImageUploader

  paginates_per 5

  def like_from(user)
    vote = votes.find_by(user_id: user.id)
    vote ||= votes.new(user_id: user.id)

    vote.flag = if vote.flag.nil?
                  increment_category_count
                  true
                elsif vote.flag.equal?(false)
                  true
                else
                  decrement_category_count
                  nil
                end
    vote.save!
  end

  def dislike_from(user)
    vote = votes.find_by(user_id: user.id)
    vote ||= votes.new(user_id: user.id)


    vote.flag = if vote.flag.nil?
                  increment_category_count
                  false
                elsif vote.flag.equal?(true)
                  false
                else
                  decrement_category_count
                  nil
                end
    vote.save!
  end

  def increment_category_count
    Category.increment_counter('count', category.id)
  end

  def decrement_category_count
    Category.decrement_counter('count', category.id)
  end
end

# def like(user)
#   vote = votes.find_by(user_id: user.id)
#   vote ||= votes.new(user_id: user.id)
#
#   vote.flag = [nil, false].include?(vote.flag) ? true : nil
#   vote.save!
# end