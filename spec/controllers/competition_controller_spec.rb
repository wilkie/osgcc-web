require_relative '../spec_helper.rb'

describe 'OSCGG-Web competitions' do

  def app
    OSGCCWeb
  end

  describe "GET /competitions" do
    it "loads" do
      get "/competitions"
      last_response.status.should == 200
    end
  end

  describe "POST /competitions", :type => :request do
    it "returns a 404 if there is no logged in user" do
      post '/competitions'
      last_response.status.should == 404
    end

    it "returns a 404 if the current user is not an admin" do
      login_as regular_user
      post '/competitions'
      last_response.status.should == 404
    end

    context "when logged in as an admin" do
      let(:params) do
        {
          :comp_name  => "test competition",
          :start_date => "2012-06-06",
          :start_time => "6:00pm",
          :end_date   => "2012-06-07",
          :end_time   => "6:00pm"
        }
      end

      before :each do
        login_as admin_user
      end

      it "creates a competition" do
        Competition.should_receive(:create)
        post '/competitions', params
      end

      it "sets the competition name" do
        post '/competitions', params
        Competition.last.name.should == params[:comp_name]
      end

      it "parses the start date" do
        post '/competitions', params
        Competition.last.start_date.should_not be_nil
      end

      it "parses the end date" do
        post '/competitions', params
        Competition.last.end_date.should_not be_nil
      end
    end
  end

  describe "GET /competitions/new" do

    it "returns a 404 if there is no logged in user" do
      get '/competitions/new'
      last_response.status.should == 404
    end

    it "returns a 404 if the current user is not an admin" do
      login_as regular_user
      get '/competitions/new'
      last_response.status.should == 404
    end

    it "lets admins create a new competition" do
      login_as admin_user
      get '/competitions/new'
      last_response.status.should == 200
    end
  end

end
