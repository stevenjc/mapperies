module UsersHelper

  def error_list(attribute)
      if @user.errors.include?(attribute)
          @user.errors.get(attribute)
      else
          []
      end
  end

end
