class AdduserIdToAlbums < ActiveRecord::Migration
  def change
    add_column :user_id, :integer
  end
end
