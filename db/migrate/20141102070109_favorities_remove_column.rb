class FavoritiesRemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :favorites, :pic
  end
end
