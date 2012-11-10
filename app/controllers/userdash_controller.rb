class UserdashController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    if current_user.role != "user"
      redirect_to root_path, notice: 'Sorry, the resource you tried to access is only available to registered clients of the website. If you are a band or not registered you will not have access to this webpage.'
    end
  end
  
end
