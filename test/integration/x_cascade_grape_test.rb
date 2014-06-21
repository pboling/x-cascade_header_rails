require 'test_helper'

class XCascadeGrapeTest < ActionDispatch::IntegrationTest

  test '/api/auth/login invalid credentials is 401' do
    get '/api/auth/login'
    assert_equal path, '/api/auth/login'
    assert_response 401, @response.body # show the response body if the assertion fails for debugging!
  end

end
