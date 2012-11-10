class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.integer :user_id
      t.string :name
      t.integer :members
      t.boolean :individual_artist
      t.string :avatar

      t.timestamps
    end
  end
end
