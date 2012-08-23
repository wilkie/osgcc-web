module AcceptanceHelpers

  def mock_auth(uid=1111)
    OmniAuth.config.mock_auth[:github][:uid] = uid
    OmniAuth.config.mock_auth[:github]
  end

  def login_as(user)
    mock_auth(user.uid)
    visit '/auth/github'
  end

  def regular_user
    @regular_user ||= User.create(:uid => 2222, :username => 'fancy carl')
  end

  def admin_user
    @admin_user ||= User.create(:uid => 3333, :username => 'amanda').tap do |u|
                      u.admin = 1
                      u.save
                    end
  end
end
