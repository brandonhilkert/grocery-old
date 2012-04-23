$: << File.expand_path('../lib', __FILE__)

require 'rubygems'
require 'grocery'

map '/assets' do
  run Grocery::App.sprockets
end

map '/' do
  run Grocery::App
end
