class AddBandprofitAndCompanyprofitToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :band_profit, :integer
    add_column :purchases, :company_profit, :integer
  end
end
