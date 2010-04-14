require 'rubygems'
require 'boxcar_api'

email = 'your email'
password = 'your password'

bu = BoxcarAPI::User.new(email, password)
res = bu.notify("message")

if res.code == 200
  puts "Success!"
else
  puts "There was a problem delivering the notification, HTTP status code: #{res.code}"
end

# This time include a 'from screen name' - e.g., an application name, or a person.
res = bu.notify("message", "from")

# This time include a unique identifier, and if you send it more than once
# additional notifications will be dropped as duplicates.
res = bu.notify("message", "from", "unique")

# This one won't be delivered, because you've already gotten it.
res = bu.notify("message", "from", "unique")