class AdmindashController < ApplicationController

  before_filter :authenticate_user!
  before_filter :verify_admin
  
  def index
    session[:trail] ||= Array.new
    if session[:trail].size > 4
      session[:trail].delete_at(0)
    end
    
    if session[:trail].first != url_for(:only_path => true)
      session[:trail].push(url_for(:only_path => true))
    end
  end
  
  def verify_admin
    if !current_user.admin?
      redirect_to root_path, notice: 'You do not have permissions to acces this page'
    end
  end
end
