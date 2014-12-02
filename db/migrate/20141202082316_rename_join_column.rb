class RenameJoinColumn < ActiveRecord::Migration
  def change
  	rename_column :actions, :join, :play
  end
end
