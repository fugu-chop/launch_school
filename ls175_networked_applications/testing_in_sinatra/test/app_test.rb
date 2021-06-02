# This value is used by various parts of Sinatra and Rack to know if the code is being tested, and in the case of Sinatra,
# Determine whether it will start a web server or not (we don't want it to if we're running tests)
ENV["RACK_ENV"] = "test"

require "minitest/autorun"
# rack/test does not come built in with Sinatra, we'll need to add the rack-test gem to our Gemfile.
require "rack/test"

require_relative "../app"

class AppTest < Minitest::Test
  # These methods expect a method called app to exist and return an instance of a Rack application when called. 
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # The response to your request will be accessible using last_response. 
  # This method will return an instance of Rack::MockResponse. 
  # Instances of this class provide status, body, and [] methods for accessing their status code, body, and headers, respectively.
  def test_index
    get "/"
    assert_equal(200, last_response.status)
    assert_equal("text/html;charset=utf-8", last_response["Content-Type"])
    assert_equal("Hello, world!", last_response.body)
  end

  # def test_sets_session_value
  #   get "/path_that_sets_session_value"
  #   assert_equal "expected value", session[:key]
  # end

  # We can also set the session value before the routing occurs.
  # There are two Hashes passed as arguments to get; 
  # the first is the Hash of parameters - e.g. any other parameters you might want to include as part of a post request
  # the second is values to be added to the request's Rack.env hash
  
  # def test_index_as_signed_in_user
  #   get "/", {}, {"rack.session" => { username: "admin"} }
  # end

  # Once values have been provided once, they will be remembered for all future calls to get or post within the same test
  # unless those values are modified by code within your application. 
  # This means that you can set values for the session in the first request made in a test and they will be retained until removed.
end

# Make sure you have minitest and rack-test gems in your Gemfile, and then use bundle exec ruby app_test.rb
