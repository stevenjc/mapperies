class AlbumView < ActiveRecord::Base
  has_many :users, through: :albums
end
