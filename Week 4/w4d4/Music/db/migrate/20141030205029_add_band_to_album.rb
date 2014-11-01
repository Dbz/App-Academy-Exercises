class AddBandToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :band_id, :integer
    add_index :albums, :band_id
  end
end
