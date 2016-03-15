class CombineUserNames < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :f_name
      t.remove :l_name
      t.string :user_name
    end
  end
end
