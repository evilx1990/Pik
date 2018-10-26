class User < ApplicationRecord
  acts_as_voter
  acts_as_votable
  acts_as_follower
  mount_uploader :avatar, AvatarUploader

  has_many :comments
  has_many :images
  has_many :categories
  has_many :activities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:registerable, :trackable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false
end
