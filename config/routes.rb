XCascadeHeaderRails::Application.routes.draw do
  match 'none' => proc { |env| [401, {}, ["Not Authorized"]] }
  match 'empty' => proc { |env| [401, {'X-Cascade' => ''}, ["Not Authorized"]] }
  match 'pass' => proc { |env| [401, {'X-Cascade' => 'pass'}, ["Not Authorized"]] }
end
