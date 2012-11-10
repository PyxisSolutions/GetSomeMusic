class AddSalesToSong < ActiveRecord::Migration
  def change
    add_column :songs, :sales, :integer
  end
end
