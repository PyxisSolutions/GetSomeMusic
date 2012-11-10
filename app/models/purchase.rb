class Purchase < ActiveRecord::Base
  validates_uniqueness_of :song_id, :scope => :user_id #users can own one song only once
  
  belongs_to :user
  
  attr_accessible :song_id, :user_id, :value
end
