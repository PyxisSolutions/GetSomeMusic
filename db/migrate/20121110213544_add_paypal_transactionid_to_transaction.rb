class AddPaypalTransactionidToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :paypal_transaction_id, :string
  end
end
