class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
      t.float :x_coord
      t.float :y_coord
      t.integer :album_id

    end
  end
end
