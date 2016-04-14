class CreateAlbumViews < ActiveRecord::Migration
  def change
    create_table :album_views do |t|
      t.integer :album_id
      t.integer :user_id
      t.integer :album_view_id
      t.integer :view_upload_access
    end
  end
end
