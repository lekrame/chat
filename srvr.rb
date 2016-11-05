#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'logger'
require 'socket'
require 'outreach'
a = TCPServer.new('', 1024) # '' means to bind to "all interfaces", same as nil or '0.0.0.0'
connection = a.accept
logfile = File.open('/home/mk/servers/chat/logs/chat.log', File::WRONLY | File::APPEND | File::CREAT)
log = Logger.new(logfile)
loop {
	@instring = connection.recv(3333).chomp
	log.info(@instring)
	case @instring
		when 'exit'
			puts "Received exit command"
			connection.write "exit"
			connection.close
			break
		when /^email/
			@arr = @instring.split(/[, ]+/)
			@arr.shift
			rcpt = @arr.shift.chomp
			pw = @arr.shift.chomp
			Outreach::Email.send(rcpt, "time for traffic probs" , pw)
			puts "send email to #{rcpt}"
			connection.write "sent email"
		when /^[sS][mM][sS]/
			@arr = @instring.split(/[ \t]+/)
			@arr.shift
			to = @arr.shift.chomp
			from = @arr.shift.chomp
			msg = @arr.shift.chomp
			Outreach::Sms.send(to, from, msg)
#			puts "Server sez: get right with messaging"
			puts "send SMS to #{to}"
			connection.write "sent SMS"
		when /^log/
			puts "get right with logging"
  		connection.write "Commands are:\nemail <rcpt> <pw>\nsms <to> <from> <msg>\nlog <msg>\n exit\n"
		when 'hello'
  		connection.write "Good day. Commands are:\nemail <rcpt> <pw>\nsms <to> <from> <msg>\nlog <msg>\n exit\n"
		else
  		connection.write "Unknown command\n"
  		connection.write "Commands are:\nemail <rcpt> <pw>\nsms <to> <from> <msg>\nlog <msg>\n exit\n"
	end
	puts "received: " + @instring
}
