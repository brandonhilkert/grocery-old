ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require 'test'
require 'grocery'
require 'factories'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

include Grocery # so we don't have to namespace EVERYTHING