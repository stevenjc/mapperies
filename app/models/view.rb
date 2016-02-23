class View < ActiveRecord::Base
  has_many :albums
  has_many :photos, :through => :albums
  has_many :users
end
