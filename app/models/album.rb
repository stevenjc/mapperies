class Album < ActiveRecord::Base
  has_attached_file :cover, {styles: { small: "64x64", med: "100x100", large: "200x200" },
                    :url  => "/assets/images/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/albums/:id/:style/:basename.:extension"}
  validates_attachment_content_type :cover, content_type: /\Acover\/.*\Z/

  #has_many :photos

  belongs_to :user
  #belongs_to :album_view
end
