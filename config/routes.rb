Rails.application.routes.draw do
  root to: 'home#index'

  # The buck stops here
  get 'none'  => proc { |env| [401, {},                       ["Not Authorized"]] }
  get 'empty' => proc { |env| [401, {'X-Cascade' => ''},      ["Not Authorized"]] }

  # This route will not respond to the request, but cascade back into this route file
  # and hit the next route that matches the request URI
  get 'cascade/401' => proc { |env| [401, {'X-Cascade' => 'pass'},  ["Not Authorized"]] }
  get 'cascade/:id' => proc { |env| [200, {},  ["Welcome"]] }
end
