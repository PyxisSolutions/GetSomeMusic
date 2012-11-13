class AddTotalCreditsPurchasedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_credits_purchased, :integer, :default => 0
  end
end
