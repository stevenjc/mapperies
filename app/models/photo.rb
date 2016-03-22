class Photo < ActiveRecord::Base
  has_attached_file :image, {styles: { small: "64x64", med: "100x100", large: "200x200" },
                  # :url  => "/assets/images/users/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/img/albums/:id/:basename.:extension"}
                  # :default_url => "users/default/:style/missing.png"}

  belongs_to :album

end
