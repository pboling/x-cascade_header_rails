Rails.application.routes.draw do

  mount RootAPI => '/api'

  devise_for :users

  root to: 'home#index'

  # The buck stops here
  match 'none'  => proc { |env| [401, {},                       ["Not Authorized"]] }
  # So this one doesn't get hit, because header X-Cascade != 'pass'
  match 'none'  => proc { |env| [200, {},                       ["Welcome"]] }

  # The buck stops here
  match 'empty' => proc { |env| [401, {'X-Cascade' => ''},      ["Not Authorized"]] }
  # So this one doesn't get hit, because header X-Cascade != 'pass'
  match 'empty' => proc { |env| [200, {},                       ["Welcome"]] }

  # This route will not respond to the request, but cascade back into this route file
  # and hit the next route that matches the request URI
  match 'cascade/401' => proc { |env| [401, {'X-Cascade' => 'pass'},  ["Not Authorized"]] }
  match 'cascade/:id' => proc { |env| [200, {},                 ["Welcome"]] }
end
