class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :band_id
      t.integer :total_purchased
      t.datetime :expires
      t.datetime :last_purchase
      t.references :user
      t.references :band

      t.timestamps
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :band_id
  end
end
