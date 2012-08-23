class Competition
  include MongoMapper::Document

  key :name,       String
  key :start_date, Time
  key :end_date,   Time

  def formatted_start
    start_date.strftime('%A %B %-d, %Y %l:%M %P')
  end

  def formatted_end
    end_date.strftime('%A %B %-d, %Y %l:%M %P')
  end
end
