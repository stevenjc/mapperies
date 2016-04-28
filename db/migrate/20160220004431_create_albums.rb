class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :album_name
      t.integer :user_id
      t.float :defaultx
      t.float :defaulty
      t.boolean :isPublic
    end
  end
end
