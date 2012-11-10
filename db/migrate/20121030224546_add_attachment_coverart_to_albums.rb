class AddAttachmentCoverartToAlbums < ActiveRecord::Migration
  def self.up
    change_table :albums do |t|
      t.has_attached_file :coverart
    end
  end

  def self.down
    drop_attached_file :albums, :coverart
  end
end
