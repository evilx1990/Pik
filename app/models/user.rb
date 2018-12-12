class User < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :follows
  has_many :images
  has_many :comments
  has_many :votes

  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable
  devise :database_authenticatable,:registerable, :trackable, :lockable,
         :recoverable, :rememberable, :validatable, :omniauthable
  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  def self.find_for_facebook_oath(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.save!(validate: false)
    end
  end

  def self.logins_before_captcha
    2
  end

  def follow(category)
    params = {
      category: category,
      user: self
    }
    category.follows.first_or_create!(params)
  end

  def stop_following(category)
    category.follows.find_by(user_id: id)&.destroy
  end

  def following?(category)
    category.follows.find_by(user_id: id)
  end
end
