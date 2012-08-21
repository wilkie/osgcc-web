class User
  include MongoMapper::Document

  key :uid,        Integer, :required => true
  key :username,   String
  key :image_url,  String
  key :admin,      Boolean, :default => false
  key :created_at, Time

  def admin?
    self.admin
  end
end
