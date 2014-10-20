class UserAddColumnPic < ActiveRecord::Migration
  def change
  	add_column :users, :info_bg, :string
  end
end
