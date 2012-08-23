# handle all of the static routes

class OSGCCWeb
  get '/' do
    haml :'home/index', :layout => :home_layout
  end

  get '/about' do
    haml :'home/about', :layout => :home_layout
  end

  get '/contact' do
    haml :'home/contact', :layout => :home_layout
  end
end
