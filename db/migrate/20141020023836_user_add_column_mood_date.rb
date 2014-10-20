class UserAddColumnMoodDate < ActiveRecord::Migration
  def change
  	add_column :users, :mood_at, :datetime
  end
end
