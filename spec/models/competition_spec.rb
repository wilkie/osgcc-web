require 'mongo_mapper'
require_relative '../../models/competition'

describe Competition do

  describe "#passed?" do

    it "returns true if the contest end_date is in the past" do
      c = Competition.new(:end_date => DateTime.yesterday)
      c.passed?.should be_true
    end

    it "returns false if the contest end_date is in the future" do
      c = Competition.new(:end_date => DateTime.tomorrow)
      c.passed?.should be_false
    end
  end

  describe "#upcoming?" do

    it "returns true if the contest start_date is in the future" do
      c = Competition.new(:start_date => DateTime.tomorrow)
      c.upcoming?.should be_true
    end

    it "returns false if the contest start_date is in the past" do
      c = Competition.new(:start_date => DateTime.yesterday)
      c.upcoming?.should be_false
    end
  end

  describe "#in_progress?" do
    it "returns true if the current time is between the start and end dates" do
      c = Competition.new(:start_date => DateTime.yesterday,
                          :end_date   => DateTime.tomorrow)
      c.in_progress?.should be_true
    end

    it "returns false if the contest is upcoming" do
      c = Competition.new(:start_date => DateTime.tomorrow,
                          :end_date   => DateTime.tomorrow + 1)
      c.in_progress?.should be_false
    end

    it "returns false if the contest has passed" do
      c = Competition.new(:start_date => DateTime.yesterday - 1,
                          :end_date   => DateTime.yesterday)
      c.in_progress?.should be_false
    end
  end
end
