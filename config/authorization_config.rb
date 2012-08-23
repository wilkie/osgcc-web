require 'omniauth'
require 'omniauth-github'

class OSGCCWeb
  set(:authorize) do |bool|
    condition do
      raise Sinatra::NotFound unless (logged_in? && current_user.admin?)
    end
  end

  use OmniAuth::Builder do
    provider :github, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
  end
end
