class OSGCCWeb
  get '/auth/github/callback' do
    auth = request.env["omniauth.auth"]

    user   = User.first( :uid => auth['uid'] )
    user ||= User.create(:uid        => auth['uid'],
                         :username   => auth['info']['nickname'],
                         :image_url  => auth['info']['image'],
                         :created_at => Time.now)

    session[:user_uid]   = user.uid
    session[:user_token] = auth['credentials']['token']
    redirect '/'
  end

  get '/logout' do
    session[:user_uid]   = nil
    session[:user_token] = nil
    redirect '/'
  end
end
