class AddTrackTypeDefault < ActiveRecord::Migration
  def change
    remove_column :tracks, :track_type
    add_column :tracks, :track_type, :string, default: "Regular"
  end
end
