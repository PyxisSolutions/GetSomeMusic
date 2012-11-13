class Song < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :cost, :band_id, :user_id
  
  
  has_attached_file :mp3, 
                    :storage => :dropbox, 
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                    :dropbox_options => { :path => proc { "#{mp3.original_filename}"}}
                    #:url => "http://dl.dropbox.com/u/24593987/" + "#{mp3.original_filename}"
  
  belongs_to :band
  belongs_to :album
  
  attr_accessible :band_id, :cost, :download_url, :name, :user_id, :mp3, :tag_list
  acts_as_taggable
end
