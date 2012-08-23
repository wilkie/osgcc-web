# handle all of the static routes

class OSGCCWeb
  get '/' do
    haml :'home/index', :layout => :default_layout
  end

  get '/about' do
    haml :'home/about', :layout => :default_layout
  end

  get '/contact' do
    haml :'home/contact', :layout => :default_layout
  end
end
