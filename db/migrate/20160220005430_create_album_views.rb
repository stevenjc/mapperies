class CreateAlbumViews < ActiveRecord::Migration
  def change
    create_table :album_views do |t|
      t.integer :album_id
      t.integer :user_id

    end
  end
end
