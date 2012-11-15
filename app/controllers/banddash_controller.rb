class BanddashController < ApplicationController

  before_filter :authenticate_user!
    
  def index
    session[:trail] ||= Array.new
    
    if session[:trail].size > 4
      session[:trail].delete_at(0)
    end
    
    if session[:trail].first != url_for(:only_path => true)
      session[:trail].push(url_for(:only_path => true))
    end
  end
  
  def create
    if current_user.band.nil?
      @band = Band.new
      @band.name = params[:band][:name]
      @band.members = params[:band][:members]
      @band.user_id = current_user.id
      @band.individual_artist = params[:band][:individual_artist]
      @band.earned = 0
      @band.earned_company = 0
      @band.subscription = Subscription.new
      @band.subscription.user_id = current_user.id
      @band.subscription.total_purchased = 0;
      @band.subscription.expires = Time.now
      
      if @band.save
        redirect_to banddash_index_path
      else
        redirect_to banddash_index_path, notice: 'Successfully created your band!'      
      end
    else
        redirect_to banddash_index_path, notice: 'An error occured.'
    end
  end
  
  def destroy
    if current_user.band.destroy
      redirect_to banddash_index_path, notice: 'Successfully deleted your band!'
    else
      redirect_to banddash_index_path, notice: 'An error occured.'     
    end
  end
  
  def show
    @band = Band.find(params[:id])
  end
end
