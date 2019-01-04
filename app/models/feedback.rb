class Feedback < ApplicationRecord
  validates :email_author,  presence: true
  validates :name,          presence: true
  validates :feedback,      presence: true
end