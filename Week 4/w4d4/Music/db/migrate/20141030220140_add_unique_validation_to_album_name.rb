class AddUniqueValidationToAlbumName < ActiveRecord::Migration
  def change
    add_index :albums, [:name, :band_id]
  end
end
