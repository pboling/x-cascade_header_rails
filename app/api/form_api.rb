class FormAPI < Grape::API

  resource :auth do

    namespace :form do
      desc "provide access_token for valid login; log in user"
      params do
        requires :username, type: String, desc: "email address"
        requires :password, type: String, desc: "password"
      end
      post :login do
        warden.authenticate!(:scope => :user)
        { :auth_token => current_user.authentication_token }
      end
    end

  end

end
