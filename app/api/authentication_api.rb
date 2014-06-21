class AuthenticationAPI < Grape::API

  # Defines the endpoint: /svc/auth
  # Requires parameters: :auth_token
  mount TokenAPI

  # Defines the endpoint /svc/auth/form
  # Requires parameters: :username and :password
  mount FormAPI

  format :json

  # These are some generic endpoints with no required parameters
  # /auth/login - this will allow login via HTTP Basic
  # /auth/logout
  resources :auth do
    # The is a very loose API.
    # No parameter restrictions.
    # Will attempt all the strategies configured in devise/warden
    # So you can send it token, oauth, header or username/password to login here.
    desc "login via an accepted authentication strategy"
    post 'login' do
      warden.authenticate!(:scope => :user)
      { :auth_token => current_user.authentication_token }
    end
    # This is the logout method that will be used by Shop site.
    desc "logout the current user"

    # Accept requests for logout via get/post/delete
    get 'logout' do
      warden.logout(:user)
      { "status" => "ok" }
    end
    post 'logout' do
      warden.logout(:user)
      { "status" => "ok" }
    end
    delete 'logout' do
      warden.logout(:user)
      { "status" => "ok" }
    end

    ### EXAMPLES ###
    # An authenticated API call
    # Will raise an error and respond appropriately when not authenticated.
    desc "authenticated call"
    get :test do
      authenticated_user
      { "status" => "ok" }
    end
    # An authenticated and authorized API call
    # Will raise an error and respond appropriately when not authenticated or when authenticated, but not an admin.
    desc "authenticated call for an admin"
    get :test_admin do
      authenticated_admin
      { "status" => "ok" }
    end
  end

end
