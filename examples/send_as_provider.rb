require 'rubygems'
require 'boxcar_api'

SETTINGS = {
  :provider_key => 'xyz',
  :provider_secret => 'xyz',
  :email => 'user@example.com'
}

bp = BoxcarAPI::Provider.new(SETTINGS[:provider_key], SETTINGS[:provider_secret])

#### Send an invitation to a user by their e-mail address, to add your service.
res = bp.subscribe(SETTINGS[:email])

if res.code == 200
  puts "Success!  You sent an invitation to #{SETTINGS[:email]} to add your service."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end

#### Deliver a broadcast notification to everyone that has added your service.
res = bp.broadcast("This is an example message.", "from")

if res.code == 200
  puts "Success!  You sent a broadcast message to everyone using your service."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end

#### Deliver a personalized notification to a subscriber by email.
res = bp.notify(SETTINGS[:email], "This is an example message.", "from")

if res.code == 200
  puts "Success!  You sent a personalized message to #{SETTINGS[:email]}."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end

#### Deliver a personalized notification to a subscriber by email, but only deliver it once!
# This includes the from_remote_service_id for the user, which will ensure it's only delivered one time.
res = bp.notify(SETTINGS[:email], "This is an example message.", "from", "123")

if res.code == 200
  puts "Success!  You sent a personalized message to #{SETTINGS[:email]}."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end

#### Deliver a personalized notification to a subscriber by email, including a redirect payload
# Redirect payloads are what replaces "::user::" in your Boxcar redirect URL.

res = bp.notify(SETTINGS[:email], "This is an example message.", "from", nil, "jdg")
if res.code == 200
  puts "Success!  You sent a personalized message with a redirect payload to #{SETTINGS[:email]}."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end

#### Deliver a personalized notification to a subscriber by email, including a redirect payload
# Redirect payloads are what replaces "::user::" in your Boxcar redirect URL.
# Also include a source_url and an icon_url

res = bp.notify(SETTINGS[:email], "This is an example message.", "from", nil, "jdg", "http://google.com", 
                "http://graph.facebook.com/jonathan.george/picture")
if res.code == 200
  puts "Success!  You sent a personalized message with a redirect payload, source_url and icon_url to #{SETTINGS[:email]}."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end


#### Deliver a personalized notification to a subscriber by their service token/secret.
#### This works, just commented out because it's much easier to use e-mail addresses.
#
#res = bp.notify_service(token, secret, "This is an example message.", "from")

#if res.code == 200
#  puts "Success!  You sent a broadcast message to everyone using your service."
#else
#  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
#end