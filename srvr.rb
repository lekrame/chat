#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'logger'
require 'socket'
require 'outreach'

homedir = `cd;pwd`.chomp
puts "home dir is #{homedir}"
system("mkdir -p #{homedir}/servers/chat/logs")
a = TCPServer.new('', 1024) # '' means to bind to "all interfaces", same as nil or '0.0.0.0'
connection = a.accept
connection.write "Welcome.  Commands are:\n\temail <rcpt>\n\tsms <to> <msg>\n\tlog <msg>\n\texit\n\nEnter password to secrets: "
@secretspw = connection.recv(255).chomp
Outreach::Secrets.load("secrets.enc", @secretspw)
connection.write "Enter command: "
logfile = File.open("#{homedir}/chat/logs/chat.log", File::WRONLY | File::APPEND | File::CREAT)
log = Logger.new(logfile)
loop {
	@instring = connection.recv(255).chomp
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
			Outreach::Email.send(rcpt, "time for traffic probs")
			puts "send email to #{rcpt}"
			connection.write "sent email"
		when /^[sS][mM][sS]/
			@arr = @instring.split(/[ \t]+/)
			@arr.shift
			to = @arr.shift.chomp
			from = @arr.shift.chomp
			msg = @arr.shift.chomp
			Outreach::Sms.send(to, $twiliophone, msg)
			puts "send SMS to #{to}"
			connection.write "sent SMS"
		when /^log/
			puts "get right with logging"
  		connection.write "Commands are:\nemail <rcpt>\nsms <to> <msg>\nlog <msg>\n exit\n"
		when 'hello'
  		connection.write "Good day. Commands are:\nemail <rcpt>\nsms <to> <msg>\nlog <msg>\n exit\n"
		else
  		connection.write "Unknown command\n"
  		connection.write "Commands are:\nemail <rcpt>\nsms <to> <msg>\nlog <msg>\n exit\n"
	end
	puts "received: " + @instring
}
