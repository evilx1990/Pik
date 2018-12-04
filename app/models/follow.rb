class Follow < ActiveRecord::Base
  belongs_to :category, counter_cache: :follows_count
  belongs_to :user


end
