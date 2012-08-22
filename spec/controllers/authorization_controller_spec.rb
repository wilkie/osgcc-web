require_relative '../spec_helper.rb'

describe 'OSGCC-Web authentications' do

  def app
    OSGCCWeb
  end

  describe "/login" do

    it "redirects to the github authentication" do
      get '/login'
      last_response.should be_redirect
      last_response.location.should == 'http://example.org/auth/github'
    end
  end

  describe "/auth/github/callback" do

    it "creates a user from the auth uid if none exists" do
      get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth}
      User.last.uid.should equal mock_auth[:uid]
    end

    it "logs the user in" do
      login_as regular_user
      last_request.env['rack.session'][:user_uid].should == regular_user.uid
    end

    it "saves the token in the session" do
      login_as regular_user
      last_request.env['rack.session'][:user_token].
        should == mock_auth[:credentials][:token]
    end
  end

  describe "/logout" do

    before :each do
      login_as regular_user
    end

    it "logs the user out" do
      get '/logout'
      last_request.env['rack.session'][:user_uid].should be_nil
    end

    it "drops the user token" do
      get '/logout'
      last_request.env['rack.session'][:user_token].should be_nil
    end
  end
end
