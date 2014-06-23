require 'grape'
require 'warden'

#require_relative 'helpers/authentication_helpers'
#require_relative 'helpers/error_helpers'
#require_relative 'authentication/form_api'
#require_relative 'authentication/token_api'
#require_relative 'authentication_api'
#require_relative 'bad_authentication'
#require_relative 'strategies/base_strategy'
#require_relative 'strategies/basic_strategy'
#require_relative 'strategies/form_strategy'
#require_relative 'strategies/header_token_strategy'

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
  # Uncomment the line below to return error status codes in a normal HTTP response.
  # Leave it commented to raise errors unhandled.
  #rescue_from :all

  helpers AuthenticationHelpers
  helpers ErrorHelpers

  mount AuthenticationAPI

  resource :info do
    get do
      { "status" => "ok" }
    end
  end
end
