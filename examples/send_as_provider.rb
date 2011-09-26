require 'rubygems'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "/lib/boxcar_api"))

  provider_key    = 'key'
  provider_secret = 'secret'
  email           = 'a_users_email'

provider = BoxcarAPI::Provider.new(provider_key, provider_secret)

#### Subscribe a user to your service
res = provider.subscribe(email)
puts res.code

#### Deliver a personalized notification to a subscriber by email.
res = provider.notify(email, "This is an example message")
puts res.code

#### Deliver a personalized notification to a subscriber by email, but only deliver it once!
# This includes the from_remote_service_id for the user, which will ensure it's only delivered one time.
res = provider.notify(email, "This is an example message. It should only be delivered once.", :from_remote_service_id => "123")
puts res.code

#### Deliver a notification with a custom screen name.
# This is added to the title as the user or application responsible for the message
res = provider.notify(email, "This is an example message from Rachel.", :from_screen_name => "Rachel")
puts res.code

#### You can also set a default screen name for notications when initializing your provider
another_provider = BoxcarAPI::Provider.new(provider_key, provider_secret, "Exmplr")
res = another_provider.notify(email, "This is an example message from Exmplr")
puts res.code

#### Deliver a notification with a source URL. 
# This is the URL the user will be taken to when they open your message.
res = provider.notify(email, "You have an update.", :source_url => "http://example.com/status/1312430")
puts res.code

#### Deliver a notification with an icon. 
res = provider.notify(email, "You have an update.", :icon_url => "http://example.com/public/icon")
puts res.code

#### Deliver a notification to a subset of your subscribers.
users = ["user1@example.com", "user2@example.com"]
res = provider.batch_notify(users, "This is a batch example message.", :from_screen_name => "Support", :from_remote_service_id => "123", :source_url => "http://example.com/status/1312430")
puts res.code


#### Deliver a broadcast notification to everyone that has added your service.
res = provider.broadcast("This is an example message.", :icon_url => "http://example.com/public/icon", :from_remote_service_id => "1232331")
puts res.code
