class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :image, counter_cache: :votes_count
end