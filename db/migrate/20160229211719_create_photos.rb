class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
      t.float :x_coord
      t.float :y_coord
      t.integer :album_id
      # t.string :image_file_name
      # t.string :image_content_type
      # t.string :image_file_size
      # t.string :image_updated_at
    end
  end
end
