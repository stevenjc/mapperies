class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.boolean :f_book
      t.string :default_loc

    end
  end
end
