class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :credit_id
      t.boolean :successful
      t.string :ip_during_purchase
      t.integer :credits_value
      t.datetime :purchase_date
      t.references :credit

      t.timestamps
    end
    add_index :transactions, :credit_id
  end
end
