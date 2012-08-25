class Team
  include MongoMapper::Document

  key :name,           String,  :required => true
  key :user_ids,       Array,   :default => []
  key :competition_id, Integer, :required => true

  belongs_to :competition
  many       :users, :in => :user_ids, :class_name => "User"

  timestamps!
end
