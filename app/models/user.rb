class User < ApplicationRecord
  acts_as_follower
  mount_uploader :avatar, AvatarUploader

  has_many :comments
  has_many :images
  has_many :categories
  has_many :activities
  has_many :votes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  def self.find_for_facebook_oath(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.save!(validate: false)
    end
  end
end
