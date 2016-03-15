module UsersHelper

  def error_list(attribute)
      if @user.errors.include?(attribute)
          @user.errors[attribute].to_a
      else
          []
      end
  end

end
