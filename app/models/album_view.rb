class Album_view < ActiveRecord::Base
  has_many :users, through: :albums
end
