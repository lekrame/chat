require 'socket'
a = TCPServer.new('', 1024) # '' means to bind to "all interfaces", same as nil or '0.0.0.0'
@count = 0
loop {
  connection = a.accept
  puts "received:" + connection.recv(3333)
  connection.write @count.to_s
  @count +=1
  connection.close
}
