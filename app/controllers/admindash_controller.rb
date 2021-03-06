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
  
  def social
    YAML.load_file( Rails.root + 'config/social.yml')
    q = Hash.new  
    q = { 
     "facebook"=>"https://facebook.com", 
     "twitter"=>"https://twitter.com"
    } 
   
   if !params['facebook'].nil? and params['facebook'] != ""
     q['facebook'] = params['facebook'] 
   end
   if !params['twitter'].nil? and params['twitter'] != ""
     q['twitter'] = params['twitter']
   end   
    File.open(Rails.root + 'config/social.yml', "w") {|f| f.write(q.to_yaml) }
   
    redirect_to admindash_index_path, notice: 'successfully updated social links!'
  end
  
  def financial
    finance_yaml = YAML.load_file( Rails.root + 'config/fa4afsy453sfa.yml')
    q = Hash.new  
    q = { 
     "business" => finance_yaml['business'], 
     "currency-code"=>finance_yaml['currency-code'],
     "domain" => 'getsomemusic.herokuapp.com',
     "sandbox" => '.sandbox'
     }
     
    if !params['account'].nil? and params['account'] != ""
      q['business'] = params['account'] 
    end
    if !params['currency'].nil? and params['currency'] != ""
      q['currency-code'] = params['currency']
    end 
    
    
    if !params['sandbox'].nil? and params['sandbox'] != ""
      q['sandbox'] = params['sandbox'] 
    end
    if !params['domain'].nil? and params['domain'] != ""
      q['domain'] = params['domain']
    end 
    
    File.open(Rails.root + 'config/fa4afsy453sfa.yml', "w") {|f| f.write(q.to_yaml) }
    redirect_to admindash_index_path, notice: 'Successfully updated Paypal account info!'
  end
end
