require 'rubygems'

$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'rufinol'
require 'rspec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/stubs/**/*.rb"].each {|f| require f}

require 'rspec/expectations'

Rspec.configure do |config|
  # == Mock Framework

  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.before(:each) do

  end

end
