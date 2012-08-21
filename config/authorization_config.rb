require 'omniauth'
require 'omniauth-github'

class OSGCCWeb
  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end
end
