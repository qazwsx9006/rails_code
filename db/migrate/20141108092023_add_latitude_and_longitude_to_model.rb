class AddLatitudeAndLongitudeToModel < ActiveRecord::Migration
  def change
    add_column :favorites, :latitude, :float
    add_column :favorites, :longitude, :float
  end
end
