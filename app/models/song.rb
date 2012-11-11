

class Song < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :cost, :band_id, :user_id
  
  has_attached_file :mp3, 
#                    :url => "/music/:attachment/:id_partition/:style/:filename",
#                    :path => ":rails_root/music/:attachment/:id_partition/:style/:filename"
                    :storage => :dropbox,
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                    :dropbox_options => { :path => proc { "#{mp3.original_filename}"}}
                    
#                    :path => "/:attachment/:attachment/:id/:style/:filename"
  
  belongs_to :band
  belongs_to :album
  
  attr_accessible :band_id, :cost, :download_url, :name, :user_id, :mp3, :tag_list
  acts_as_taggable
end
