#module RackupAppHelper
#  def app
#    RackupApp::app.to_app
#  end
#end

RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup,
                 type: :request
  config.include Warden::Test::Helpers,
                 type: :request
  #config.include RackupAppHelper,
  #               type: :request
  config.backtrace_exclusion_patterns = [
      /spec_helper/
  ]
end
