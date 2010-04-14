require 'rubygems'
require 'boxcar_api'

provider_key = 'xyz'
provider_secret = 'xyz'

bp = Provider.new(provider_key, provider_secret)

#### Send an invitation to a user by their e-mail address, to add your service.
res = bp.subscribe('user@example.com')

if res.code == 200
  puts "Success!  You sent an invitation to user@example.com to add your service."
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
res = bp.broadcast("user@example.com", "This is an example message.", "from")

if res.code == 200
  puts "Success!  You sent a broadcast message to everyone using your service."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end

#### Deliver a personalized notification to a subscriber by their service token/secret.
res = bp.broadcast(token, secret, "This is an example message.", "from")

if res.code == 200
  puts "Success!  You sent a broadcast message to everyone using your service."
else
  puts "Problem!  HTTP status code: #{res.code}.  Check the API docs!"
end