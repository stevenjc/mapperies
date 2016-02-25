class Album < ActiveRecord::Base

  has_many :photos
  belongs_to :users
  belongs_to :album_views

end
