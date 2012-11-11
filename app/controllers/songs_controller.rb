  class SongsController < ApplicationController

  before_filter :authenticate_user!

  def create  
    if !current_user.band.nil?
      @song = Song.new(params[:song])
      @song.sales = 0
      @song.user_id = current_user.id
      @song.band_id = current_user.band.id

#      if @song.save
          redirect_to banddash_index_path, notice: 'Successfully uploaded song.'
#      else
#        redirect_to banddash_index_path, notice: 'Error during song creation'
#      end
    else
      redirect_to banddash_index_path, notice: 'Error during song creation'
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

    if @song.destroy
      redirect_to banddash_index_path, notice: 'Song deleted successfully.' 
    else
      redirect_to banddash_index_path, notice: 'Failed to delete song.' 
    end
  end
  
   def show
    @song = Song.find(params[:id])
  end
end
