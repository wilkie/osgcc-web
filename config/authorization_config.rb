require 'omniauth'
require 'omniauth-github'

class OSGCCWeb
  set(:authorize) do |level|
    condition do
      case level
      when :user
        redirect "/login" unless logged_in?
      when :admin
        raise Sinatra::NotFound unless (logged_in? && current_user.admin?)
      end
    end
  end

  use OmniAuth::Builder do
    provider :github, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
  end
end
