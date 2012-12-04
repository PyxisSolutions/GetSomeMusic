class SongsController < ApplicationController

  before_filter :authenticate_user!

  def create  
    unless current_user.band.nil?
      @song = Song.new(params[:song])
      @song.sales = 0
      @song.user_id = current_user.id
      @song.band_id = current_user.band.id
      
      #so it turns out ptools can only check for binary files and 
      #filemagic is too outdated and non-secure
      #so i wrote my own by reading the first 3 bytes, they should always be ID3 for mp3 files.
      #in other words it reads the head of the file which stores metadata about it.
      if IO.read(params[:song][:mp3].open, 3).to_s == 'ID3'
        if @song.save
          redirect_to banddash_index_path, notice: 'Successfully uploaded song.'
        else
          redirect_to banddash_index_path, notice: 'Error during song upload.'
        end
      else
        redirect_to banddash_index_path, notice: 'Error ONLY mp3 files allowed, it ending in .mp3 does not make it a mp3 file!!!'
      end
    else
      redirect_to banddash_index_path, notice: 'Error during song creation!'
    end
  end

  def edit
    @song = Song.find(params[:id])
  end
  
  def update
    
    @song = Song.find(params[:song][:id])
    
    if !params[:song][:name].nil? 
      @song.name = params[:song][:name]
    end
    
    if !params[:song][:cost].nil? 
      @song.cost = params[:song][:cost]
    end
    
    if !params[:song][:album_id].nil?
      @song.album_id = params[:song][:album_id]
    end
    
    if @song.save
      redirect_to banddash_index_path, notice: 'Successfully updated.' 
    else
      redirect_to banddash_index_path, notice: 'Error during update' 
    end
  end

  def destroy
    @song = Song.find(params[:id])
    
    if @song.user_id == current_user.id
      if @song.destroy
      redirect_to banddash_index_path, notice: 'Song deleted successfully.' 
      else
        redirect_to banddash_index_path, notice: 'Failed to delete song.' 
      end
    else
      redirect_to banddash_index_path, notice: 'What are you doing? You cant delete songs you down own!' 
    end
  end
  
  def show
    session[:trail] ||= Array.new
    if session[:trail].size > 4
      session[:trail].delete_at(0)
    end
    
    if session[:trail].last != url_for(:only_path => true)
      session[:trail].push(url_for(:only_path => true))
    end
    
    @song = Song.find(params[:id])
  end
end
