class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name
      t.timestamps :time
      t.integer :gac_id
      t.boolean :join

      t.timestamps
    end
  end
end
