class Band < ActiveRecord::Base
  validates_uniqueness_of :name

  belongs_to :user
  has_many :songs
  has_one :subscription
  
  attr_accessible :avatar, :individual_artist, :members, :name, :user_id
  
  def has_subscription(band)
    # to use: <%= track.band.has_subscription %>
    if !band.subscription.nil?
      if band.subscription.expires > Date.today.to_time
        return true
      end
        return false
    end
  end
  
end
