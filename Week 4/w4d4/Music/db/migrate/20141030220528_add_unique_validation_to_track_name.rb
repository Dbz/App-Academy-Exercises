class AddUniqueValidationToTrackName < ActiveRecord::Migration
  def change
    add_index :tracks, [:name, :album_id]
  end
end
