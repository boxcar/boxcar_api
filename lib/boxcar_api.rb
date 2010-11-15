require 'rubygems'
require 'httparty'
require 'digest/md5'

require 'boxcar_api/provider'

module BoxcarAPI

################### For Users - http://boxcar.io/help/api/users
  class User
    include HTTParty
    attr_accessor :auth
    base_uri "https://boxcar.io/notifications"

    def initialize(email, password)
      @auth = { :username => email, :password => password }
    end

    def notify(message, from_screen_name = nil, from_remote_service_id = nil, source_url = nil, icon_url = nil)
      options = { :basic_auth => @auth, :body => { 
        :notification => {
          :message => message,
          :from_screen_name => from_screen_name,
          :from_remote_service_id => from_remote_service_id,
          :icon_url => icon_url,
          :source_url => source_url
        }
      }}

      self.class.post("/", options)
    end
  end
end
