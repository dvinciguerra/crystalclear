require "json"
require "kemal"
require "kemal-watcher"

require "dotenv"
Dotenv.load

messages = [] of String
sockets = [] of HTTP::WebSocket

before_all do |env|
  env.response.headers["Access-Control-Allow-Origin"] = "*"
  env.response.headers["Access-Control-Allow-Methods"] = "GET, HEAD, POST, PUT"
  env.response.headers["Access-Control-Allow-Headers"] = "Content-Type, Accept, Origin, Authorization"

  env.response.content_type = "application/json"
end

options "/*" do |env|
  env.response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
  env.response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

  halt env, 200
end

get "/event/questions" do |env|
  {
    "questions": messages.map do |message|
      JSON.parse message
    end,
  }.to_json
end

ws "/event/stream" do |socket|
  sockets.push(socket)

  socket.on_message do |message|
    payload = JSON.parse(message).raw.as(Hash)
    # payload["createdAt"] = JSON::Any.new Time::Format::ISO_8601_DATE_TIME.format(Time.utc)

    pp payload
    STDOUT.flush

    messages.unshift(payload.to_json)

    sockets.each do |a_socket|
      next if a_socket == socket
      a_socket.send(payload.to_json)
    end
  end

  socket.on_close do |_|
    sockets.delete(socket)
    puts "Closing Socket: #{socket}"
  end
end

# watcher
files = ["*.cr"]
Kemal.watch(files)

# server
Kemal.run do |config|
  ENV["PORT"] ||= "3000"
  ENV["HOST"] ||= "0.0.0.0"

  puts "Starting server http://#{ENV["HOST"]}:#{ENV["PORT"]}"

  server = config.server.not_nil!
  server.bind_tcp ENV["HOST"], ENV["PORT"].to_i, reuse_port: true
end
