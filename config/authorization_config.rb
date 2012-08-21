require 'omniauth'
require 'omniauth-github'

class OSGCCWeb
  use OmniAuth::Builder do
    provider :github, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
  end
end
