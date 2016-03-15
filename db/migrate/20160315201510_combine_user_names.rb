class CombineUserNames < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :user_name
    end
  end
end
