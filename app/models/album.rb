class Album < ActiveRecord::Base
  #has_many :photos

  belongs_to :user
  #belongs_to :album_view
end
