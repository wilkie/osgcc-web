require_relative '../spec_helper'

describe User do

  let(:user) { User.new(:username => "Normy", :uid => 1234)}

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
