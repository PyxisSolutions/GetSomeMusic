class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :song_id
      t.integer :value

      t.timestamps
    end
  end
end
