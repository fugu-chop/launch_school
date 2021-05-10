require "socket"

def parse_request(request_line)
  split_address = request_line.split
  path_split = split_address[1].split("?")
  http_method = split_address.first
  http_version = split_address.last
  path = path_split.first

  params = path_split.last.split("&").each_with_object(Hash.new) do |pair, hash| 
    key, value = pair.split("=")
    hash[key] = value.to_i
  end

  [http_method, http_version, path, params]
end

# Create a TCP server for the Transport layer
# When we create a server locally we typically want to use a non-standard port to avoid conflicts with real applications
server = TCPServer.new("localhost", 3003)
loop do
  # This waits until a client attempts to request something from the server
  # Once the request comes through, server.accept accepts that request and opens a connection to the client
  # This returns an object that we can interact with the remote system
  client = server.accept

  # We use gets to grab the first line of the request (the text being sent from the client to the server)
  request_line = client.gets
  # This is printed in the CLI
  puts request_line
  # Necessary because browsers issue another request after the GET request in the URL
  next if !request_line || request_line =~ /favicon/

  http_method, http_version, path, params = parse_request(request_line)

  # This required is because Chrome expects a well-formed response to be sent to it for rendering. 
  # We need a valid response-line before anything else (i.e. the message body).
  client.puts "#{http_version} 200 OK"
  client.puts "Content-Type: text/html; charset=utf-8"
  # There has to be a blank line between the status line, optional headers, and the message body.
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  
  client.puts "<pre>"
  client.puts request_line
  client.puts "Method: #{http_method}"
  client.puts "Path: #{path}"
  client.puts "HTTP Version: #{http_version}"
  client.puts "Query Strings: #{params}"
  client.puts "</pre>"

  client.puts "<h1>Rolls</h1>"
  params["rolls"].times { |_| client.puts "<p> #{rand(params["sides"]) + 1} </p>" }

  client.puts "</body>"
  client.puts "</html>"
  client.close
end
