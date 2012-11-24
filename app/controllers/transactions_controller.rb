class TransactionsController < ApplicationController
  protect_from_forgery :except => [:notify]
  before_filter :authenticate_user!, :except => [:notify]
  
  def create
    
    @value = 0
    @item_name = 'music credits'
    #log transaction
    @transaction = Transaction.new
    @transaction.credit_id = current_user.credit.id
    @transaction.user_id = current_user.id
    @transaction.ip_during_purchase = request.remote_ip
    @transaction.purchase_date = Time.now
    @transaction.successful = false #will be set to true on paypal callback if payment is successful
    
    #band subscription
    if !params[:transaction][:sub].nil? and params[:transaction][:sub] == 'q4DaFUbr'
      @transaction.credits_value = 3000
      @transaction.transaction_type = 'subscription'
      @value = 30
      @item_name = "3 Month GetSomeMusic band subscription."
      current_user.band.subscription.last_purchase = Date.today
    #user buying credits
    else
      @value = params[:transaction][:credit]
      @transaction.transaction_type = 'credit'
      @transaction.credits_value = (params[:transaction][:credit].to_i * 100)
    end
    
    #I was going to call it finance.yaml but it seems like a bad idea
    y = YAML.load_file( Rails.root + 'config/fa4afsy453sfa.yml') 
    
    if @transaction.save
      @sandbox = '.sandbox'
      if y['sandbox'] == '' 
        @sandbox = ""
      end
      
      values = {
        :business => y['business'],
        :cmd => "_cart",
        :currency_code => y['currency-code'],
        :quantity => 1,
        :amount_1 => @value,
        :item_name_1 => @item_name,
        :upload => "1",
        :return => "https://" + y['domain'] + "/credits/update?tid=" + @transaction.id.to_s,
        :invoice => @transaction.id.to_s,
        :notify_url => "https://" + y['domain'] + "/transactions/notify/"
      }
      redirect_to "https://www" + @sandbox + ".paypal.com/cgi-bin/websrc?" + values.map { |param,value| "#{param}=#{value}" }.join("&")
    end
    
  rescue
    redirect_to home_index_path, notice: "Something went wrong."
  end

  def notify
    @transaction = Transaction.find(params[:invoice])
    @transaction.paypal_transaction_id = params[:tnx_id]
    @user = User.find(@transaction.user_id)
    
    
    if !@transaction.successful and !params[:payment_status].nil? and (params[:payment_status] == "Completed" or params[:payment_status] == "completed")

      if @transaction.transaction_type == 'credit'
        #increment the user's credits
        @transaction.successful = true;
        @user.credit.count += @transaction.credits_value;
        
        if @user.total_credits_purchased.nil?
          @user.total_credits_purchased = @transaction.credits_value
        else
          @user.total_credits_purchased += @transaction.credits_value
        end
        
        @user.credit.save and @user.save and @transaction.save
      else
        #give 3 month subscription to the band
        @user.band.subscription.total_purchased += 1
        @user.band.subscription.last_purchase = Date.today
        @user.band.subscription.expires = Date.today.to_time.advance(:months => 3).to_date   
        
        if !@user.band.earned_company.nil? 
          @user.band.earned_company += @transaction.credits_value
        else
          @user.band.earned_company = @transaction.credits_value
        end
        
        @transaction.successful = true
        @user.band.save and @user.band.subscription.save and @transaction.save

      end
    end
    
    render :nothing => true
  rescue
    puts 'Something went terribly wrong at transaction ' + @transaction.id.to_s + ' Please check the state of the transaction and contact the effected user: UID' + @user.id.to_s
  end
end
