class User < ActiveRecord::Base
  include Clearance::User
  popular

  has_many :friender_friends, foreign_key: :friendee_id, class_name: "Friend"
  has_many :frienders, through: :friender_follows, source: :friender
  has_many :friendee_friends, foreign_key: :friender_id, class_name: "Friend"
  has_many :friendees, through: :friendee_friends, source: :friendee

  validates :password, length: {minimum: 6, too_short: "must be at least six characters long"}

 # @test = User.find(1)
 # @test2 = User.find(2)
 # @test.befriend @test2
end
