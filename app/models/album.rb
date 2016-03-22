class Album < ActiveRecord::Base
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  #has_many :photos

  belongs_to :user
  #belongs_to :album_view
end
