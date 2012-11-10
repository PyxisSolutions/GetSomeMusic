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
    @transaction.successful = false #default
    @transaction.transaction_type = 'credit'
    
    
    if !params[:transaction][:sub].nil? and params[:transaction][:sub] == 'q4DaFUbr'
      puts 'YAEH BEBI'
      @transaction.credits_value = 3000
      @transaction.transaction_type = 'subscription'
      @value = 30
      @item_name = "3 month GetSomeMusic subscription."
      current_user.band.subscription.last_purchase = Date.today
      #3 month subscription
    else
      @value = params[:transaction][:credit]
      @transaction.credits_value = (params[:transaction][:credit].to_i * 100)
    end
    
    if @transaction.save
      values = {
        :business => "sales_1351862433_biz@abv.bg", #should come from a file
        :cmd => "_cart",
        :currency_code => "GBP",
        :quantity => 1,
        :amount_1 => @value,
        :item_name_1 => @item_name,
        :upload => "1",
        :return => "https://localhost:3000/credits/update?tid=" + @transaction.id.to_s,
        :invoice => @transaction.id.to_s,
        :notify_url => "https://localhost:3000/transactions/" + @transaction.id.to_s + '/'
      }

      redirect_to "https://www.sandbox.paypal.com/cgi-bin/websrc?" + values.map { |param,value| "#{param}=#{value}" }.join("&")
    end
    
  rescue
    redirect_to home_index_path, notice: "Something went wrong."
  end

  def notify
    @transaction = Transaction.find(params[:invoice].to_i)
    @transaction.paypal_transaction_id = params[:tnx_id]
    @user = User.find(@transaction.user_id)
    
#    if !params[:payment_status].nil? and (params[:payment_status] == "Complete" or params[:payment_status] == "complete")
#      @transaction.successful = true;
#      @user.band.subscription.total_purchased += 1
#      @user.band.subscription.last_purchase = Date.today
#      @user.band.subscription.expires = Date.today.to_time.advance(:months => 3).to_date 
#    end

    @user.band.subscription.save and @transaction.save
    puts 'tid: ' +@transaction.id.to_s + ' uid:' + @user.id.to_s + ' isdone?:' + params[:payment_status].to_s + ' ____' + (params[:payment_status] == 'Complete').to_s
    send_data 'asdfa'
  end
end
