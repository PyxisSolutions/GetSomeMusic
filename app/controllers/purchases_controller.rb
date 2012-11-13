class PurchasesController < ApplicationController
  before_filter :authenticate_user!
          
  def create
    if current_user.credit.count >= Song.find(params[:purchase][:song_id]).cost #user has to have enough credits to purchase song
      if current_user.current_sign_in_ip == request.remote_ip
        
        @song = Song.find(params[:purchase][:song_id])
        @purchase = current_user.purchases.build( :song_id => params[:purchase][:song_id], :value => @song.cost)
        
        @band = Band.find(@song.band_id)
        @band.earned += @song.cost
        #@band.earned_company += (@song.cost / 10)
        @band.songs_sold += 1
        
        @purchase.company_profit = 0
        @purchase.band_profit = @song.cost
        
        current_user.credit.count -= @song.cost #charge user for purchasing song
        
        if @purchase.save and current_user.credit.save and @band.user.credit.save and @band.save
          redirect_to userdash_index_path, notice: 'Sucessfully purchased song'
        else
          redirect_to userdash_index_path, notice: 'An error occured during your purchase' + ' You have not been charged.'
        end
      end
    else
      redirect_to request.referrer.to_s, notice: "Sorry but you dont have enough credits to purchase this " + 
        "song. You can purchase credits by going to the home page and clicking 'Purchase music credits'."
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    if @purchase.destroy
      redirect_to userdash_index_path, notice: 'Deleted purchase successfully.'
    else
      redirect_to userdash_index_path, notice: 'Failed to delete purchase.'
    end
  end
  
  def displayall
    @restoftable = '<tr class="info"><td>Band</td><td>Song</td><td>Price</td><td>Purchased</td><td>Download</td></tr>'
    
    current_user.purchases.all.reverse.each do |p|
      @song = Song.find(p.song_id)
      @price = (p.value.to_d / 100).to_s
      
      @restoftable += 
        '<tr>' +
          '<td>' + @song.band.name + '</td>' +
          '<td>' + @song.name + '</td>' +
          '<td>' + @price + '0' + '</td>' +
          '<td>' + p.created_at.strftime("%d %b %Y") + '</td>' +
          '<td>' + '<a href="/home/download?sid=' + @song.id.to_s + '">Download</a>' + '</td>' +
        '</tr>'
    end
    
    send_data @restoftable
  end
end
