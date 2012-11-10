class AddTotalsoldToBand < ActiveRecord::Migration
  def change
    add_column :bands, :songs_sold, :integer, :default => 0
  end
end
