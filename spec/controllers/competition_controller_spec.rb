require_relative '../spec_helper.rb'

describe 'OSCGG-Web competitions' do

  def app
    OSGCCWeb
  end

  describe "/competitions" do
    it "loads" do
      get "/competitions"
      last_response.status.should == 200
    end
  end

  describe "/competitions/new" do
    let(:user) do
      User.new(:uid => 1)
    end

    let(:admin_user) do
      User.create(:uid => 2).tap do |u|
        u.admin = 1
        u.save
      end
    end

    it "returns a 404 if there is no logged in user" do
      get '/competitions/new'
      last_response.status.should == 404
    end

    it "returns a 404 if the current user is not an admin" do
      get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth(user.uid)}
      get '/competitions/new'
      last_response.status.should == 404
    end

    it "lets admins create a new competition" do
      get '/auth/github/callback', nil, {"omniauth.auth" => mock_auth(admin_user.uid)}
      get '/competitions/new'
      last_response.status.should == 200
    end
  end
end
