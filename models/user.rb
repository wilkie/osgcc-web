class User
  include MongoMapper::Document

  key :uid,        Integer, :required => true
  key :username,   String
  key :created_at, Time
end
