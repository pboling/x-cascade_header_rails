require 'test_helper'

class XCascadeRackTest < ActionDispatch::IntegrationTest
  test '/none is 401 error' do
    get '/none'
    assert_equal path, '/none'
    assert_response 401, @response.body # show the response body if the assertion fails for debugging!
  end

  test '/empty is 401 error' do
    get '/empty'
    assert_equal path, '/empty'
    assert_response 401, @response.body # show the response body if the assertion fails for debugging!
  end

  test '/cascade/401 is 200 error' do
    get '/cascade/401'
    assert_equal path, '/cascade/401'
    assert_response 200, @response.body # show the response body if the assertion fails for debugging!
  end

end
