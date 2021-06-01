require "sinatra"

configure do
  enable(:sessions)
  set(:session_secret, 'secret')
end

# To get at the session object and its values, we can use last_request.env["rack.session"]
# This is useful for our test suite
def session
  last_request.env["rack.session"]
end

get "/" do
  "Hello, world!"
end
