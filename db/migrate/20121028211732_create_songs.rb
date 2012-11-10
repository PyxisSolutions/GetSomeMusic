class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :user_id
      t.integer :band_id
      t.integer :cost
      t.string :download_url
      t.string :name

      t.timestamps
    end
  end
end
