class Follow < ActiveRecord::Base
  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true, counter_cache: :follows_count
  belongs_to :follower,   polymorphic: true

  def block!
    update_attribute(:blocked, true)
  end
end
