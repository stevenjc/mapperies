class User < ActiveRecord::Base
  include Clearance::User

  #include Clearance::User

#  has_many :albums
#  has_many :views
#  has_many :photos, :through => :albums

  has_many :friender_friends, foreign_key: :friendee_id, class_name: "Friend"
  has_many :frienders, through: :friender_follows, source: :friender
  has_many :friendee_friends, foreign_key: :friender_id, class_name: "Friend"
  has_many :friendees, through: :friendee_friends, source: :friendee
end
