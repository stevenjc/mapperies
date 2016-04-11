class Photo < ActiveRecord::Base
  has_attached_file :image, {styles: { small: "64x64", med: "100x100", large: "200x200" },
                  :url  => "/assets/photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    Paperclip.interpolates :album_id do |attachment, style|
      attachment.inatance.album_id
    end

  belongs_to :album

end
