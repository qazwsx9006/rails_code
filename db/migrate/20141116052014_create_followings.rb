class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :following
      t.integer :followed

      t.timestamps
    end
  end
end
