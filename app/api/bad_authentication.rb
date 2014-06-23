class BadAuthentication
  class << self
    def call(env)
      @rack_static = ::Rack::Static.new(
          lambda { [403, {}, []] }, {
          :root => File.expand_path('../../public', __FILE__),
          :urls => %w[/]
      })
      @rack_static.call(env.merge({'PATH_INFO' => "/errors/403.html"}))
    end
  end
end
