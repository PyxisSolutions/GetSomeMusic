class Transaction < ActiveRecord::Base
  belongs_to :credit
  
  attr_accessible :credit_id, :credits_value, :ip_during_purchase, :purchase_date, :successful, :user_id
end
