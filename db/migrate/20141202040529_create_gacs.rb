class CreateGacs < ActiveRecord::Migration
  def change
    create_table :gacs do |t|
      t.string :name
      t.integer :age
      t.integer :grade
      t.string :add
      t.string :phone
      t.string :fb
      t.string :line
      t.text :other

      t.timestamps
    end
  end
end
