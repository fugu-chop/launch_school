require "socket"

def parse_request(request_line)
  split_address = request_line.split
  path_split = split_address[1].split("?")
  http_method = split_address.first
  http_version = split_address.last
  path = path_split.first

  if request_line =~ /\?/
    params = path_split.last.split("&").each_with_object(Hash.new) do |pair, hash| 
      key, value = pair.split("=")
      hash[key] = value
    end
  else
    params = Hash.new
  end 

  [http_method, http_version, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept
  request_line = client.gets
  
  next if !request_line || request_line =~ /favicon/

  http_method, http_version, path, params = parse_request(request_line)
  # Attempting to access a hash key that doesn't exist returns nil, nil.to_i returns 0
  number = params["number"].to_i

  client.puts "#{http_version} 200 OK"
  client.puts "Content-Type: text/html; charset=utf-8"
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

  client.puts "<h1>Counter</h1>"
  client.puts "<p>The current number is #{number}!</p>"
  # We don't reassign the number variable, as HTTP is stateless, we need to update number based on URL
  client.puts "<p><a href='/?number=#{number + 1}'>Increment number!</p>"
  client.puts "<p><a href='/?number=#{number - 1}'>Decrement number!</p>"

  client.puts "</body>"
  client.puts "</html>"
  client.close
end
