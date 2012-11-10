class AdmindashController < ApplicationController

  before_filter :authenticate_user!
  before_filter :verify_admin
  
  def index
    
  end
  
  def verify_admin
    if !current_user.admin?
      redirect_to root_path, notice: 'You do not have permissions to acces this page'
    end
  end
end
