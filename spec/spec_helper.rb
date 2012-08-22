ENV['RACK_ENV'] = 'test'

require 'database_cleaner'
require 'mongo_mapper'
require 'omniauth'
require 'rack/test'
require_relative '../osgcc_web'

MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database   = "osgcc_test"

RSpec.configure do |config|
  config.include Rack::Test::Methods

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


def mock_auth(uid=1111)
  OmniAuth.config.mock_auth[:github][:uid] = uid
  OmniAuth.config.mock_auth[:github]
end
