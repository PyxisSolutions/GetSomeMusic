class RemoveAvatarFromBand < ActiveRecord::Migration
  def up
    remove_column :bands, :avatar
  end

  def down
    add_column :bands, :avatar, :string
  end
end
