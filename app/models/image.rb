class Image < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :likes, -> { where(flag: true) }, class_name: 'Vote'
  has_many :dislikes, -> { where(flag: false) }, class_name: 'Vote'

  belongs_to :category, counter_cache: :images_count
  belongs_to :user

  validates :picture, presence: true, file_size: { less_than: 50.megabytes }
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :picture, ImageUploader

  paginates_per 6

  def vote_from(user_id, vote)
    vote_record = votes.find_by(user_id: user_id)
    vote_record ||= votes.new(user_id: user_id)

    vote_record.flag = vote_record.flag.eql?(vote) ? nil : vote
    vote_record.save
  end

  def self.preview(category, cur_img_ct)
    category.images.order(created_at: :desc).where(Image.arel_table[:created_at].gt(cur_img_ct)).last
  end

  def self.next(category, cur_img_ct)
    category.images.order(created_at: :desc).where(Image.arel_table[:created_at].lt(cur_img_ct)).first
  end
end