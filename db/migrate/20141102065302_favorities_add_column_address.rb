class FavoritiesAddColumnAddress < ActiveRecord::Migration
  def change
  	add_column :favorites, :store_name, :string
  	add_column :favorites, :coodinate_x, :string
  	add_column :favorites, :coodinate_y, :string
  	add_column :favorites, :address, :string
  	remove_column :favorites, :food_id
  end
end
