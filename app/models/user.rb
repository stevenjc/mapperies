class User < ActiveRecord::Base
  has_many :albums
  has_many :views
  has_many :friends
  has_many :photos, through :albums
end
