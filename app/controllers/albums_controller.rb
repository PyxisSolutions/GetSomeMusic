class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    
    @album = Album.new(params[:album])
    @album.user_id = current_user.id
    @album.band_id = current_user.band.id
    
    if @album.save
      redirect_to banddash_index_path, notice: 'Album was successfully created.'
    else
      redirect_to banddash_index_path, notice: 'Failed to create album'
    end
  end

  def destroy
  end

  def view
  end
end
