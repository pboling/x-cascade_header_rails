require 'test_helper'

class XCascadeGrapeTest < ActionDispatch::IntegrationTest

  # Rack Session is not compatible with ActionDispatch::Request::Session, so this test fails.
  # Switching to Rspec & Capybara for now.
  test '/api/auth/login invalid credentials is 401' do
    get '/api/auth/login'
    assert_equal path, '/api/auth/login'
    assert_response 401, @response.body # show the response body if the assertion fails for debugging!
  end

end
