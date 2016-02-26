class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.date :b_day
      t.boolean :f_book
      t.string :default_loc

    end
  end
end
