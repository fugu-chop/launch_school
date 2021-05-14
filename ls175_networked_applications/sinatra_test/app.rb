require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir.glob("public/*").map {|file| File.basename(file) }.sort
  # params is a hash that Sinatra makes available for you in your route blocks, and it will automatically include relevant data from the request.
  # It also contains any data sent from HTML forms as part of the HTTP request as well as any query params that can be part of the URL.
  # We can see what it contains through params.inspect
  @files.reverse! if params[:sort] == "desc"
  erb(:home)
end
