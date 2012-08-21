class OSGCCWeb

  get '/competitions' do
    @competitions = Competition.all
    haml :'competitions/index', :layout => :home_layout
  end
end
