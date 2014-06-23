require 'rails_helper'

describe AuthenticationAPI, type: :request do

  it "return a 401 status" do
    get "/api/info", {}, {'rack.session' => {} }
    expect(response.status).to eq 200
  end

  context "failed auth" do
    context "with username and password" do
      describe "GET /api/auth/login" do
        it "return a 401 status" do
          post "/api/auth/login", {username: 'wrong', password: 'invalid'}, {'rack.session' => {} }
          expect(response.status).to eq 401
          expect(JSON.parse(response.body)).to_not have_key 'auth_token'
          get "/api/auth/test_admin", {}, {'rack.session' => {} }
          expect(response.status).to eq 401
          get "/api/auth/test", {}, {'rack.session' => {} }
          expect(response.status).to eq 401
        end
      end
    end

    context "with auth_token" do
      describe "GET /api/auth/login" do
        it "return a 401 status" do
          post "/api/auth/login", {auth_token: '1234asdf5678qwer'}, {'rack.session' => {} }
          expect(response.status).to eq 401
          expect(JSON.parse(response.body)).to_not have_key 'auth_token'
          get "/api/auth/test", {}, {'rack.session' => {} }
          expect(response.status).to eq 401
          get "/api/auth/test_admin", {}, {'rack.session' => {} }
          expect(response.status).to eq 401
        end
      end
    end
  end

end
