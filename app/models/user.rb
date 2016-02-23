class User < ActiveRecord::Base
  has_many :albums
<<<<<<< HEAD
  has_many :friends
=======
  has_many :views
  has_many :friends
  has_many :photos, :through => :albums
>>>>>>> 740c20e99a6f7aa287f642aa3ea088216f6c0e8c
end
