class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :pic
      t.string :name
      t.string :coodinate_x
      t.string :coodinate_y
      t.string :address

      t.timestamps
    end
  end
end
