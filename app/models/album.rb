class Album < ActiveRecord::Base
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://imgur.com/1a0BNE5.jpg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  #has_many :photos

  belongs_to :user
  #belongs_to :album_view
end
