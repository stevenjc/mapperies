class User < ActiveRecord::Base
  include Clearance::User

  has_many :albums
  has_many :views
  has_many :friends
  has_many :photos, :through => :albums
end
