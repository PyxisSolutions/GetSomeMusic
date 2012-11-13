require 'fileutils'
require 'open-uri'

class HomeController < ApplicationController  
  before_filter :authenticate_user!, :except => [:index]
  
  def index
    
    
    Purchase.all.each do |p|
      p.destroy
    end
    
    if user_signed_in?
      if  current_user.credit.nil?
        redirect_to :controller => :credits, :action => :create
      end
    end
  end
  
  def download
    @song = Song.find(params[:sid])
    
    #>0 means user has purchased song
    if Purchase.where(:song_id => @song.id, :user_id => current_user.id).size > 0 
      @songuri =   Rails.root.to_s + '/temp/' + @song.band.name + '-' + @song.name + '.mp3'
      
      FileUtils.touch @songuri
      File.open(@songuri, "wb") do |saved_file|
        open("http://dl.dropbox.com/u/24593987/" + @song.mp3_file_name, 'rb') do |read_file|
          saved_file.write(read_file.read)
        end
        send_file saved_file  #you want to get to here!
      end
      
    else
      redirect_to root_path, notice: "You have not purchased this song and so you cant download it." +
        " If you would like to purchase the song please go on the home page and purchase it."
    end
  end
  
  def search
    @tag = params[:tag]
    @hash =  Song.tagged_with(@tag) + Song.where(:name => params[:tag])
    
    if params[:tag] == '' or params[:tag] == nil
      @hash = Song.all
    end
    
    @hash.each do |song|
      song["mp3_file_name"] = "" #seruruty risk...
      song["download_url"] = ""
      song["mp3_file_name"] = ""
      song["band_name"] = song.band.name #add the band name...
    end
    
    send_data @hash.to_json
  end
end
