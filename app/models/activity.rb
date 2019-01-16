# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to  :user

  validates :action, :url, presence: true
end
