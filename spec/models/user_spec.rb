require 'mongo_mapper'
require_relative '../../models/user'

describe User do

  let(:user) { User.new }

  describe "#admin?" do
    it "returns true if the user has sufficient priviledge" do
      user.admin = true
      user.admin?.should be_true
    end

    it "returns false for normal users" do
      user.admin?.should_not be_true
    end
  end
end
