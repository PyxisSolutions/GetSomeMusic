class User < ActiveRecord::Base
  has_many :purchases
  has_many :albums
  has_one :band
  has_one :subscription
  has_one :credit
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
end
