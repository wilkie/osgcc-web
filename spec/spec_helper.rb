ENV['RACK_ENV'] = 'test'

require 'capybara/rspec'
require 'database_cleaner'
require 'mongo_mapper'
require 'omniauth'
require 'rack/test'
require_relative '../osgcc_web'
require_relative './acceptance_helpers.rb'

MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database   = "osgcc_test"

Capybara.app = OSGCCWeb

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include AcceptanceHelpers, :type => :request

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :github,
    {
      :uid => 1111,
      :credentials => {
        :token => 'itsasecrettoeveryone'
      }
    }
  )

  config.before(:suite) do
    DatabaseCleaner[:mongo_mapper].strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
