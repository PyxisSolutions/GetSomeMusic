class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  attr_accessible :band_id, :expires, :last_purchase, :total_purchased, :user_id
end
