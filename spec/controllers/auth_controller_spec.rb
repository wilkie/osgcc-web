require_relative '../spec_helper.rb'

require 'omniauth'
require_relative '../../osgcc_web'

describe 'OSGCC-Web authentications' do

  include Rack::Test::Methods
  OmniAuth.config.test_mode = true

  def app
    OSGCCWeb
  end

  let(:mock_auth) do
    OmniAuth.config.add_mock(
      :github,
      {
        :uid => 1111,
        :credentials => {
          :token => 'itsasecrettoeveryone'
        }
      }
    )
    OmniAuth.config.mock_auth[:github]
  end

  describe "/auth/github/callback" do

    it "creates a user from the auth uid if none exists" do
      get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth}
      User.last.uid.should equal mock_auth[:uid]
    end

    it "logs the user in" do
      get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth}
      last_request.env['rack.session'][:user_uid].should equal mock_auth[:uid]
    end

    it "saves the token in the session" do
      get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth}
      last_request.env['rack.session'][:user_token].
        should equal mock_auth[:credentials][:token]
    end
  end

  describe "/logout" do

    before :each do
      get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth}
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
