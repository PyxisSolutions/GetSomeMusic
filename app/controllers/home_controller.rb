require 'fileutils'

class HomeController < ApplicationController  
  before_filter :authenticate_user!, :except => [:index]

  def index
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
      @renamed_file_url = Rails.root.to_s + '/temp/' + @song.band.name + ' - ' + @song.name + '.mp3'
      @real_file_url = Rails.root.to_s + '/music' + @song.mp3.url.sub(/\?.*.$/i, '')

      if File.exist?(@renamed_file_url) and File.file?(@renamed_file_url)
        redirect_to '/?fileexists'
      else
        FileUtils.cp(@real_file_url, @renamed_file_url) #move file to temporary location
        redirect_to '/?filenoexist'
      end

      send_file @renamed_file_url, :x_sendfile => true, :type => 'audio/mp3'
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
