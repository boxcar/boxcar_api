require 'rubygems'
require 'httparty'

module BoxcarAPI

  # For Providers - http://boxcar.io/help/api/providers
  class Provider
    include HTTParty
    attr_accessor :provider_key, :provider_secret, :screen_name

    def initialize(provider_key, provider_secret, screen_name = nil)
      @provider_key    = provider_key
      @provider_secret = provider_secret
      @screen_name     = screen_name
      self.class.base_uri "https://boxcar.io/devices/providers/#{@provider_key}/notifications"
    end

    def subscribe(email)
      params = { :body => { :email => email } }
      self.class.post("/subscribe", params)
    end

    def broadcast(message, options = {:from_screen_name => screen_name, :from_remote_service_id => nil, :source_url => nil, :icon_url => nil})
      params = { :body => { :secret => provider_secret,
        :notification => {
        :message => message,
        :from_screen_name => options[:from_screen_name],
        :from_remote_service_id => options[:from_remote_service_id],
        :source_url => options[:source_url],
        :icon_url => options[:icon_url]
      } 
      }}

      self.class.post("/broadcast", params)
    end

    def notify(email, message, options = {:from_screen_name => screen_name, :from_remote_service_id => nil, :source_url => nil, :icon_url => nil})
      params = { :body => { :email => email,
        :notification => {
        :message => message,
        :from_screen_name => options[:from_screen_name],
        :from_remote_service_id => options[:from_remote_service_id],
        :source_url => options[:source_url],
        :icon_url => options[:icon_url]
      } 
      }}

      self.class.post("/", params)
    end
    
    def batch_notify(emails, message, options = {:from_screen_name => screen_name, :from_remote_service_id => nil, :source_url => nil, :icon_url => nil})
      params = { :body => { :emails => emails,
        :notification => {
        :message => message,
        :from_screen_name => options[:from_screen_name],
        :from_remote_service_id => options[:from_remote_service_id],
        :source_url => options[:source_url],
        :icon_url => options[:icon_url]
      } 
      }}

      self.class.post("/", params)
    end
  end
end

