class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :msg
      t.integer :user_id
      t.integer :favority_id

      t.timestamps
    end
  end
end
