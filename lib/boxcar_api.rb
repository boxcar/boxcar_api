require 'rubygems'
require 'httparty'
require 'digest/md5'

module BoxcarAPI

  # For Providers - http://boxcar.io/help/api/providers
  class Provider
    include HTTParty
    attr_accessor :provider_key, :provider_secret

    def initialize(provider_key, provider_secret)
      @provider_key = provider_key
      @provider_secret = provider_secret

      self.class.base_uri "https://boxcar.io/devices/providers/#{@provider_key}/notifications"
    end

    def subscribe(email)
      options = { :body => { :email => hashed_email(email) } }
      self.class.post("/subscribe", options)
    end

    def broadcast(message, from_screen_name = nil, from_remote_service_id = nil, redirect_payload = nil, source_url = nil, icon_url = nil)
      options = { :body => { :secret => provider_secret,
        :notification => {
        :message => message,
        :from_screen_name => from_screen_name,
        :from_remote_service_id => from_remote_service_id,
        :redirect_payload => redirect_payload,
        :source_url => source_url,
        :icon_url => icon_url
      } 
      }}

      self.class.post("/broadcast", options)
    end

    def notify(email, message, from_screen_name = nil, from_remote_service_id = nil, redirect_payload = nil, source_url = nil, icon_url = nil)
      options = { :body => { :email => hashed_email(email),
        :notification => {
        :message => message,
        :from_screen_name => from_screen_name,
        :from_remote_service_id => from_remote_service_id,
        :redirect_payload => redirect_payload,
        :source_url => source_url,
        :icon_url => icon_url
      } 
      }}

      self.class.post("/", options)
    end
end

