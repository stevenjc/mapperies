class Album < ActiveRecord::Base
<<<<<<< HEAD
  has_many :photos
  belongs_to :user
  belongs_to :album_views
=======
  belongs_to :users
>>>>>>> 740c20e99a6f7aa287f642aa3ea088216f6c0e8c
end
