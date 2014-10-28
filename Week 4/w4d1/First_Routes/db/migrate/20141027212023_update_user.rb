class UpdateUser < ActiveRecord::Migration
  def change
    remove_column :users, :name, :email
    # remove_column :users, :email
    add_column :users, :username, :string, :unique => true
  end
end
