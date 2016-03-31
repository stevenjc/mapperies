Paperclip::Attachment.interpolations[:album_id] = proc do |attachment, style|
  # or whatever you've named your User's login/username/etc. attribute
  attachment.instance.login
end
