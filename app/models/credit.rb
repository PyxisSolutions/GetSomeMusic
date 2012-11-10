class Credit < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
  
  attr_accessible :count, :user_id
end
