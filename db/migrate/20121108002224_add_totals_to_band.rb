class AddTotalsToBand < ActiveRecord::Migration
  def change
    add_column :bands, :earned, :integer, :default => 0
    add_column :bands, :earned_company, :integer, :default => 0
  end
end
