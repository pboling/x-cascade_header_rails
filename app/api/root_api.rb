require 'grape'
require 'warden'

class RootAPI < Grape::API

  use Rack::Session::Cookie, :secret => 'thisisnotaverygoodsecretnowisitpleasechangethisfreakinthing'

  # cascade: false
  #   ensures that an error returned by grape as a 401 or 404 doesn't get slurped into an HTML error response downstream by Rails.
  #   can be overridden on specific API version definitions.
  #   NOTE: This doesn't seem to be honored by Devise. :(
  cascade false
  version 'v1',
          using: :header, # The version of the API is specified in the header (as opposed to the path, for example)
          vendor: 'turndown'
  format :json            # This is a JSON API.
  rescue_from :all

  helpers AuthenticationHelpers
  helpers ErrorHelpers

  mount AuthenticationAPI

end
