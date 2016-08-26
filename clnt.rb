require 'socket'
@count = 0;
while @count<3 do
	a = TCPSocket.new('127.0.0.1', 1024) # could replace 127.0.0.1 with your "real" IP if desired.
	a.write ("connection " + @count.to_s)
	puts "response #" + a.recv(3333)
	@count += 1
	sleep 1
	a.close
end
