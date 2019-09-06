module AuthenticationHelper
  def show_login
    if session[:current_user] == nil
      return link_to "Login", {:action=>"login", :controller=>"authentication"}
    else
      link_to "Logout", {:action=>"logout", :controller=>"authentication"}
    end
  end

  def show_logged_in_features
    if session[:current_user] == nil
      return false
    else
      return true
    end
  end
end
