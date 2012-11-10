class Song < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :cost, :band_id, :user_id
  
  has_attached_file :mp3, #we cant store the files in the public url!
                    :url => "/:class/:attachment/:id_partition/:style/:filename",
                    :path => ":rails_root/music/:class/:attachment/:id_partition/:style/:filename"
  
  belongs_to :band
  belongs_to :album
  
  attr_accessible :band_id, :cost, :download_url, :name, :user_id, :mp3, :tag_list
  acts_as_taggable
end
