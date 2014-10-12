class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password_digest
      t.string :nickname
      t.string :avatar
      t.string :mimi_t

      t.timestamps
    end
  end
end
