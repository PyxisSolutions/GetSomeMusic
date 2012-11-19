class CreditsController < ApplicationController
  before_filter :authenticate_user!
  
  def create #newly registered users get redirected here to create their credits field.
    @credit = Credit.new
    @credit.count = 0
    @credit.user_id = current_user.id
    
    if @credit.save    
      redirect_to home_index_path, notice: 'Successfully registered.'
    else
      redirect_to home_index_path, notice: 'An error occured'
    end
  end
  
  def update #users are redirected here after purchasing credits and after buying songs
    
    @transaction = Transaction.find(params[:tid])

    if @transaction.successful  
        redirect_to home_index_path, notice: "Successfully purchased " + @transaction.credits_value.to_s  + " credits."
    else
        redirect_to home_index_path, notice: "Purchase was nit completed. "      
    end    
  rescue #paying for credits process should be atomic
    @transaction.successful = false
    @transaction.save
    redirect_to home_index_path, notice: 'Error during update' 
  end  
end
