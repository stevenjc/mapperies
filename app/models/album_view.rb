class AlbumView < ActiveRecord::Base
  #has_many :users, through: :albums
  belongs_to :user
  belongs_to :album
end
