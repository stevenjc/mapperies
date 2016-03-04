class User < ActiveRecord::Base
  has_secure_password
  after_destroy :ensure_an_admin_remains

  private
    def ensure_an_admin_remains
      if User.where(admin: true).count.zero?
        raise "Cannot delete the last admin"
      end
    end
end
