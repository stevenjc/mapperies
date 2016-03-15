class AddCoverToAlbum < ActiveRecord::Migration
  def self.up
    change_table :albums do |t|
      t.string :url
    end
  end
end
