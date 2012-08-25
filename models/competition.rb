class Competition
  include MongoMapper::Document

  key :name,       String
  key :start_date, Time
  key :end_date,   Time

  many :teams

  timestamps!

  def self.upcoming
    Competition.where(:start_date.gt => Time.now)
  end

  def self.in_progress
    Competition.where(:start_date.lte => Time.now,
                      :end_date.gte   => Time.now)
  end

  def self.passed
    Competition.where(:end_date.lt => Time.now)
  end

  def self.upcoming_or_in_progress
    Competition.where(:end_date.gt => Time.now)
  end

  def formatted_start
    start_date.strftime('%A %B %-d, %Y %l:%M %P')
  end

  def formatted_end
    end_date.strftime('%A %B %-d, %Y %l:%M %P')
  end

  def passed?
    return DateTime.now > end_date
  end

  def upcoming?
    return DateTime.now < start_date
  end

  def in_progress?
    return !(passed? || upcoming?)
  end
end
