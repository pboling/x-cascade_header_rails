#module RackupApp
#  class << self
#    def app
#      @app ||= Rack::Builder.new do
#        #use Rack::Session::Cookie
#        #Warden::Manager.serialize_into_session { |user| user.id }
#        #Warden::Manager.serialize_from_session { |id| User.find(id) }
#        #use Warden::Manager do |manager|
#        #  manager.default_strategies :password, :basic
#        #  manager.failure_app = BadAuthentication
#        #end
#        run RootAPI.new
#      end
#    end
#  end
#end
