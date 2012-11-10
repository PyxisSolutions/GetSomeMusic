class RemoveAvatarFromAlbum < ActiveRecord::Migration
  def up
    remove_column :albums, :avatar
  end

  def down
    add_column :albums, :avatar, :string
  end
end
