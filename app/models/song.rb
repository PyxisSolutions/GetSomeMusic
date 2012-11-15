class Song < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :cost, :band_id, :user_id
  validates_attachment_content_type :audio, :content_type => ['audio/mp3'], message: "Wrong content type, only MP3 files are allowed", notice: "Wrong content type, only MP3 files are allowed"
  
  has_attached_file :mp3, 
                    :storage => :dropbox, 
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                    :dropbox_options => { :path => proc { "#{mp3.original_filename}"}}
                    #:url => "http://dl.dropbox.com/u/24593987/" + "#{mp3.original_filename}"

  before_post_process :rename_mp3

  
  belongs_to :band
  belongs_to :album
  
  attr_accessible :band_id, :cost, :download_url, :name, :user_id, :mp3, :tag_list
  acts_as_taggable
  
  
  def rename_mp3
#    extension = File.extname(mp3_file_name).downcase
    
    #how is this for code golf and overkill ?
    o =  [('a'..'z'),('A'..'Z'),(1..9)].map{|i| i.to_a}.flatten
    new_file_name  =  (0...50).map{ o[rand(o.length)] }.join
    
    self.mp3.instance_write :file_name, "#{new_file_name.to_s}" #"#{new_file_name.to_s}#{extension}"
  end
end
