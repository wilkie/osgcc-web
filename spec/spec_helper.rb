ENV['RACK_ENV'] = 'test'

require 'database_cleaner'
require 'mongo_mapper'
require 'rack/test'
require_relative '../osgcc_web'

MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database   = "osgcc_test"

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner[:mongo_mapper].strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
