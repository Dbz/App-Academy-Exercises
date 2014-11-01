class CreateAlbum < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      
      t.timestamps
    end
    add_index :albums, :name, unique: true
  end
end
