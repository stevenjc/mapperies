module MainHelper

    def user_identifier
        if current_user.user_name
            return current_user.user_name
        else
            return current_user.email
        end
    end
end
