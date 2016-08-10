module UsersHelper
    def render_user_status(user)
      if user.is_hidden
        "(Hidden)"
      else
        "(Public)"
      end
    end
  
end
