#!/usr/bin/ruby
require 'socket'
if (ARGV[0].nil?) then
	printf "Enter IP address of server: "
	@serverip = STDIN.gets
else
	@serverip = ARGV[0].dup
end
@serverip.chomp!
a = TCPSocket.new(@serverip, 1024) # 127.0.0.1 is localhost
#a = TCPSocket.new("#{@serverip}", 1024) # 127.0.0.1 is localhost
@api = a.recv(128).chomp
puts @api
STDIN.gets
a.write($_);
loop {
	@api = a.recv(128)
	if @api =~ /^exit$/
		puts "Closing after receiving exit command\n"
		a.write("exit")
		a.close
		break
	end
	puts "response: " + @api + "\nNext command?: "
	STDIN.gets
	puts "sending #{$_}"
	a.write($_)
}
puts "\nEnd of dialogue"
