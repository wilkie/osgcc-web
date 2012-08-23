class OSGCCWeb

  get '/competitions' do
    @competitions = Competition.all
    haml :'competitions/index', :layout => :home_layout
  end

  post "/competitions", :authorize => :admin do

    name       = params[:comp_name]
    start_date = DateTime.strptime("#{params[:start_date]}T#{params[:start_time]}","%Y-%m-%dT%I:%M%P")
    end_date   = DateTime.strptime("#{params[:end_date]}T#{params[:end_time]}","%Y-%m-%dT%I:%M%P")
    c = Competition.create(:name => name, :start_date => start_date, :end_date => end_date)

    redirect "/competitions/#{c._id.to_s}"
  end

  get '/competitions/new', :authorize => :admin do
    haml :'competitions/new', :layout => :home_layout
  end

  get '/competitions/:id' do
    @competition = Competition.find(params[:id])
    haml :'competitions/show', :layout => :home_layout
  end

  get '/competitions/:id/edit', :authorize => :admin do
    @competition = Competition.find(params[:id])
    haml :'competitions/edit', :layout => :home_layout
  end

  post '/competitions/:id', :authorize => :admin do
    @competition = Competition.find(params[:id])

    name       = params[:comp_name]
    start_date = DateTime.strptime("#{params[:start_date]}T#{params[:start_time]}","%Y-%m-%dT%I:%M%P")
    end_date   = DateTime.strptime("#{params[:end_date]}T#{params[:end_time]}","%Y-%m-%dT%I:%M%P")
    @competition.update_attributes(:name => name, :start_date => start_date, :end_date => end_date)

    redirect "/competitions/#{@competition._id.to_s}"
  end
end
