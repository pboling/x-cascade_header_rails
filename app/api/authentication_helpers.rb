module AuthenticationHelpers
  # :public api
  def warden
    env['warden']
  end
  # :public api
  def current_user
    warden.user || User.find_for_token_authentication("auth_token" => params[:auth_token])
  end
  # :public api
  def is_admin?
    current_user && current_user.admin?
  end
  # :public api
  # returns 401 if there's no current user
  def authenticated_user
    authenticated
    error!('401 Unauthorized', 401) unless current_user
  end
  # :public api
  # returns 401 if not authenticated as admin
  def authenticated_admin
    authenticated
    error!('401 Unauthorized', 401) unless is_admin?
  end

  # :private api
  def authenticated
    if warden.authenticated?
      return true
    else
      error!('401 Unauthorized', 401)
    end
  end
end
