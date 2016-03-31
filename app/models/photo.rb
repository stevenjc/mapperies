class Photo < ActiveRecord::Base
  has_attached_file :image, {styles: { small: "64x64", med: "100x100", large: "200x200" },
                  # :url  => ":rails_root/app/assets/images/users/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/img/albums/:album_id/:basename.:extension"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :album

end
