class AddColumnToUserHeartSum < ActiveRecord::Migration
  def change
  	add_column :users, :heart_sum, :integer, default: 0
  end
end
