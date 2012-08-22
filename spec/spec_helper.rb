ENV['RACK_ENV'] = 'test'

require 'capybara/rspec'
require 'database_cleaner'
require 'mongo_mapper'
require 'omniauth'
require 'rack/test'
require_relative '../osgcc_web'

MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database   = "osgcc_test"

Capybara.app = OSGCCWeb

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

def login_as(user)
  get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth(user.uid)}
end

def regular_user
  @regular_user ||= User.create(:uid => 2222)
end

def admin_user
  @admin_user ||= User.create(:uid => 3333).tap do |u|
                    u.admin = 1
                    u.save
                  end
end

