require 'sinatra'

set :haml, :format => :html5

get '/' do
  haml :index, :layout => :home_layout
end

get '/about' do
  haml :about, :layout => :home_layout
end

get '/contact' do
  haml :contact, :layout => :home_layout
end
