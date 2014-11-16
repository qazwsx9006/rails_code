class CangeFollowingColumnName < ActiveRecord::Migration
  def change
  	rename_column :followings, :following , :following_id
  	rename_column :followings, :followed , :followed_id
  end
end
