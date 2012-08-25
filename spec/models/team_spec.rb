require_relative '../spec_helper'

describe Team do

  describe "#member?" do

    let(:user) { User.create(:username => "Norman", :uid => 1234) }

    it "returns true if the given user is a member of the team" do
      t = Team.new(:users => [user])
      t.member?(user).should be_true
    end

    it "returns false if the given user is not a member of the team" do
      t = Team.new
      t.member?(user).should be_false
    end
  end

  describe "#full?" do

    it "returns true if the team has 3 members" do
      users = (0..2).map{ |i| User.create(:uid => i) }
      t = Team.new(:users => users)
      t.full?.should be_true
    end

    it "returns false if the team has less than 3 members" do
      users = (0..1).map{ |i| User.create(:uid => i) }
      t = Team.new(:users => users)
      t.full?.should be_false
    end
  end
end
