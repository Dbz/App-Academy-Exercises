class ChangeIndexOnAlbum < ActiveRecord::Migration
  def change
    remove_index :albums, :name # Remove Unique: True
    add_index :albums, :name
  end
end
