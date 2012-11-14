class UserdashController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    session[:trail] ||= Array.new
    

    if session[:trail].first != url_for(:only_path => true)
      session[:trail].push(url_for(:only_path => true))
    end
    
    if session[:trail].size > 4
      session[:trail].delete_at(0)
    end
    
    if current_user.role != "user"
      redirect_to root_path, notice: 'Sorry, the resource you tried to access is only available to registered clients of the website. If you are a band or not registered you will not have access to this webpage.'
    end
  end
  
end
