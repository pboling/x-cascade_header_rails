XCascadeHeaderRails::Application.routes.draw do
  # The buck stops here
  match 'none'  => proc { |env| [401, {},                       ["Not Authorized"]] }
  match 'empty' => proc { |env| [401, {'X-Cascade' => ''},      ["Not Authorized"]] }

  # This route will not respond to the request, but cascade back into this route file
  # and hit the next route that matches the request URI
  match 'cascade/401' => proc { |env| [401, {'X-Cascade' => 'pass'},  ["Not Authorized"]] }
  match 'cascade/:id' => proc { |env| [200, {},  ["Welcome"]] }
end
