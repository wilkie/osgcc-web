class User
  include MongoMapper::Document

  key :uid,        Integer, :required => true
  key :username,   String
  key :image_url,  String
  key :admin,      Boolean, :default => false

  timestamps!

  def admin?
    self.admin
  end
end
