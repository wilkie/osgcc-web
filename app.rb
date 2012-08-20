require 'sinatra'
require 'mongo_mapper'
require_relative 'models/user'

set :haml, :format => :html5

configure do
  MongoMapper.database = 'osgcc'
end

get '/' do
  haml :index, :layout => :home_layout
end

get '/about' do
  haml :about, :layout => :home_layout
end

get '/contact' do
  haml :contact, :layout => :home_layout
end
