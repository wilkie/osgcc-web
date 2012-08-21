class Competition
  include MongoMapper::Document

  key :name,       String
  key :start_date, Time
  key :end_date,   Time
end
