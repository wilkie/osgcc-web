require_relative '../spec_helper.rb'

describe 'OSCGG-Web competitions' do

  def app
    OSGCCWeb
  end

  describe "/competitions" do
    it "loads" do
      get "/competitions"
      last_response.should be_ok
    end
  end
end
