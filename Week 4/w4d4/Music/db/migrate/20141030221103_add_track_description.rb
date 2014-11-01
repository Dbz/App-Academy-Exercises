class AddTrackDescription < ActiveRecord::Migration
  def change
    add_column :tracks, :description, :text
    add_column :tracks, :track_type, :string
  end
end
