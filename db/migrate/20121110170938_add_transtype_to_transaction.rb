class AddTranstypeToTransaction < ActiveRecord::Migration
  def change
    remove_column :transactions, :type, :string
  end
end
