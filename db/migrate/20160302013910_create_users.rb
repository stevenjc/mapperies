class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :admin  #0 false  #1 true
      t.timestamps null: false
    end
  end
end
