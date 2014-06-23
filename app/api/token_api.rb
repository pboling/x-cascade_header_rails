class TokenAPI < Grape::API

  resource :auth do

    namespace :token do
      desc "validates an access_token; log in user"
      params do
        requires :auth_token, type: String, desc: "Access token."
      end
      post do
        warden.authenticate!(:scope => :user)
        { :auth_token => current_user.authentication_token }
      end
    end

  end

end
