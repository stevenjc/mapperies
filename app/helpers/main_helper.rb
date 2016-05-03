module MainHelper
    def user_identifier
      if current_user
        if current_user.user_name
            return current_user.user_name
        elsif current_user.first_name
            return current_user.first_name
        else
            return current_user.email
        end
      end
    end
end
