class User < ApplicationRecord
  acts_as_votable

  has_many :comments
  has_many :images

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:registerable,
         :recoverable, :rememberable, :validatable
  validates_uniqueness_of :username
end
