require "rubygems"
require "rspec"
require 'yaml'
require 'ephemeral_response'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "boxcar_api"

Rspec.configure do |config|
  config.before(:suite) do
    EphemeralResponse.activate
  end

  config.after(:suite) do
    EphemeralResponse.deactivate
  end
end
