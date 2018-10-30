class User < ApplicationRecord
  acts_as_voter
  acts_as_votable
  acts_as_follower
  mount_uploader :avatar, AvatarUploader

  has_many :comments
  has_many :images
  has_many :categories
  has_many :activities

  def email_required?
    false
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  def self.find_for_facebook_oath(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    return user if user

    User.create(username: auth.extra.raw_info.name,
                provider: auth.provider,
                uid: auth.uid,
                email: auth.info.email,
                avatar: auth.info.image,
                password: Devise.friendly_token[0, 20])
  end
end
