# frozen_string_literal:true

class Image < ApplicationRecord
  has_many    :comments, dependent: :destroy
  has_many    :votes, dependent: :destroy
  has_many    :likes, -> { where(flag: true) }, class_name: 'Vote'
  has_many    :dislikes, -> { where(flag: false) }, class_name: 'Vote'
  belongs_to  :category, counter_cache: :images_count
  belongs_to  :user

  validates :picture, presence: true, file_size: { less_than: 50.megabytes }
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :picture, ImageUploader

  # vote must contain true/false
  def vote_from(user, vote)
    vote_record = votes.find_by(user: user)
    vote_record ||= votes.new(user: user)

    vote_record.flag = vote_record.flag.eql?(vote) ? nil : vote
    vote_record.save
  end

  def liked?(user)
    Vote.find_by(image: self, user: user)&.flag.eql?(true)
  end

  def disliked?(user)
    Vote.find_by(image: self, user: user)&.flag.eql?(false)
  end

  # get previous image in category
  def self.previous(category, cur_img_at)
    category.images.order(created_at: :desc).where(Image.arel_table[:created_at].gt(cur_img_at)).last
  end

  # get next image in category
  def self.next(category, cur_img_at)
    category.images.order(created_at: :desc).where(Image.arel_table[:created_at].lt(cur_img_at)).first
  end
end
