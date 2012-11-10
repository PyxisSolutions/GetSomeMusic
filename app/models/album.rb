class Album < ActiveRecord::Base
  validates_uniqueness_of :name
  
  has_attached_file :coverart
  
  validates_attachment_presence :coverart
  validates_attachment_size :coverart, :less_than => 5.megabytes
  validates_attachment_content_type :coverart, :content_type => ['image/jpeg', 'image/png']
    
  has_many :songs
  belongs_to :band
  belongs_to :user
  
  attr_accessible :band_id, :coverart, :name, :user_id
end
