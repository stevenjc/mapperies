class Photo < ActiveRecord::Base
  has_attached_file :image, {styles: { small: "64x64", med: "100x100", large: "200x200" },
                  # :url  => ":rails_root/app/assets/images/users/:id/:style/:basename.:extension",
                  # :url => ":rails_root/public/img/albums/:album_id/:basename.:extension",
                  # :url  => "/assets/photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/img/albums/:album_id/:basename.:extension"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    Paperclip.interpolates :album_id do |attachment, style|
      attachment.instance.album_id
    end

  belongs_to :album

end
