class FavoriteAddCommentsCount < ActiveRecord::Migration
  def change
  	add_column :favorites, :comment_sum, :integer, default: 0
  end
end
