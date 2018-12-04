class Image < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :likes, -> { where(flag: true) }, class_name: 'Vote'
  has_many :dislikes, -> { where(flag: false) }, class_name: 'Vote'

  belongs_to :category, counter_cache: :images_count
  belongs_to :user

  validates :picture, presence: true, file_size: { less_than: 50.megabytes }
  validates :image_name, presence: true, length: { minimum: 3, maximum: 15 }

  extend FriendlyId
  friendly_id :image_name, use: :slugged

  mount_uploader :picture, ImageUploader

  paginates_per 5

  def vote_from(user_id, vote)
    vote_record = votes.find_by(user_id: user_id)
    vote_record ||= votes.new(user_id: user_id)

    vote_record.flag = vote_record.flag.eql?(vote) ? nil : vote
    vote_record.save
  end
end