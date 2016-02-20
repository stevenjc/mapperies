class User < ActiveRecord::Base
  has_many :albums
  has_many :friends
end
