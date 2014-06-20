Rails.application.routes.draw do
  get 'none' => proc { |env| [401, {}, ["Not Authorized"]] }
  get 'empty' => proc { |env| [401, {'X-Cascade' => ''}, ["Not Authorized"]] }
  get 'pass' => proc { |env| [401, {'X-Cascade' => 'pass'}, ["Not Authorized"]] }
end
