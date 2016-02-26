class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :friender
      t.integer :friendee

    end
  end
end
