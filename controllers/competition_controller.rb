class OSGCCWeb

  get '/competitions' do
    @competitions = Competition.all
    haml :'competitions/index', :layout => :home_layout
  end

  post "/competitions" do
    return 404 unless (logged_in? && current_user.admin?)

    name       = params[:comp_name]
    start_date = DateTime.strptime("#{params[:start_date]}T#{params[:start_time]}","%Y-%m-%dT%I:%M%P")
    end_date   = DateTime.strptime("#{params[:end_date]}T#{params[:end_time]}","%Y-%m-%dT%I:%M%P")
    Competition.create(:name => name, :start_date => start_date, :end_date => end_date)
  end

  get '/competitions/new' do
    return 404 unless (logged_in? && current_user.admin?)
    haml :'competitions/new', :layout => :home_layout
  end

end
