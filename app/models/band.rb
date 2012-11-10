class Band < ActiveRecord::Base
  validates_uniqueness_of :name

  belongs_to :user
  has_many :songs
  has_one :subscription
  
  attr_accessible :avatar, :individual_artist, :members, :name, :user_id
end
