#!/usr/bin/ruby
require 'socket'
a = TCPServer.new('', 1024) # '' means to bind to "all interfaces", same as nil or '0.0.0.0'
connection = a.accept
loop {
	@instring = connection.recv(3333).chomp
	break if @instring == 'exit'
	puts "received: " + @instring + "\nReply?: "
	gets
  connection.write $_
}
puts "Received exit command"
connection.close
