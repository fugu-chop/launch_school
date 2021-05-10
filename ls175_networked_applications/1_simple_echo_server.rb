require "socket"

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

  # We send the first line of the request to the client so it appears in the web browser
  client.puts request_line

  split_address = request_line.split
  path_split = split_address[1].split("?")
  http_method = split_address.first
  path = path_split.first

  client.puts "Method: #{http_method}"
  client.puts "Path: #{path}"

  if request_line =~ /\?/
    params = path_split.last.split("&").map { |pair| pair.split("=") }.to_h
    params = params.transform_values { |value| value.to_i }
    params["rolls"].times { |_| client.puts rand(params["sides"]) + 1 }
  else
    client.puts rand(6) + 1
  end
  
  client.close
end

=begin
If you try to run your echo server in Chrome, then you may run into some issues. 
This is because Chrome expects a well-formed response to be sent to it for rendering. 
To account for this, be sure to add a valid status line to your response first, before adding the content of the message body. 
There also has to be a blank line between the status line, optional headers, and the message body.

client.puts "HTTP/1.1 200 OK"
client.puts "Content-Type: text/plain\r\n\r\n"
=end
