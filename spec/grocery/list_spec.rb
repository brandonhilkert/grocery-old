require 'spec_helper'

describe List do
  include Rack::Test::Methods

  it { subject.id.should have(10).letters }
end