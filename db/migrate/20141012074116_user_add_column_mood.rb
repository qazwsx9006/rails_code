class UserAddColumnMood < ActiveRecord::Migration
  def change
  	add_column :users, :mood, :string
  	add_column :users, :about, :string
  end
end
