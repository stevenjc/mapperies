class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :album_id
      t.integer :xcoord
      t.integer :ycoord

      t.timestamps null: false
    end
  end
end
