class FavoritiesAddColumn < ActiveRecord::Migration
  def change
  	add_column :favorites, :user_id, :integer
  	add_column :favorites, :food_id, :integer
  end
end
