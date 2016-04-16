class User < ActiveRecord::Base
  include Clearance::User
#  before_create :generate_authentication_token
  popular

  has_many :friender_friends, foreign_key: :friendee_id, class_name: "Friend"
  has_many :frienders, through: :friender_follows, source: :friender
  has_many :friendee_friends, foreign_key: :friender_id, class_name: "Friend"
  has_many :friendees, through: :friendee_friends, source: :friendee

  validates :password, length: {minimum: 6, too_short: "must be at least six characters long"}


  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break unless User.find_by(authentication_token: authentication_token)
    end
  end

  # You can also use a symbol here but the friendship won't be passed to your method
 # after_befriend 'notify_friendship_created value'
 # after_unfriend 'notify_unfriended value'

  #def notify_friendship_created(friendship)
   # gon.testFriendship = "#{friendship.popular_model_id} friended #{friendship.friend}"
  #end

  #def notify_unfriended(friendship)
   # puts "#{name} unfriended #{friendship.friend.name}"
  #end

 # @test = User.find(1)
 # @test2 = User.find(2)
 # @test.befriend @test2
end
