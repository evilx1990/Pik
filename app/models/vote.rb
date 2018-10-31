class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :image

  after_save :counters_update

  private

  def counters_update
    image.likes_count = image.votes.where(flag: true).count
    image.dislikes_count = image.votes.where(flag: false).count
    image.save!
  end
end