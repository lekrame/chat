#!/usr/bin/ruby
require 'socket'

a = TCPSocket.new('127.0.0.1', 1024) # could replace 127.0.0.1 with your "real" IP if desired.
a.write("hello")
loop {
	@api = a.recv(128)
	if @api =~ /^exit$/
		puts "Closing after receiving exit command\n"
		a.write("exit")
		a.close
		break
	end
	puts "response: " + @api + "\nNext command?: "
	gets
	a.write($_)
}
puts "End of dialogue"
