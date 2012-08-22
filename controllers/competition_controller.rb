class OSGCCWeb

  get '/competitions' do
    @competitions = Competition.all
    haml :'competitions/index', :layout => :home_layout
  end

  get '/competitions/new' do
    return 404 unless (logged_in? && current_user.admin?)
    haml :'competitions/new', :layout => :home_layout
  end
end
