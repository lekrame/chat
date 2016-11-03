#!/usr/bin/ruby -w
require 'mail'

fromAddress = 'pianospree@gmail.com'
toAddress = 'mk@pianospree.com'
now = Time.new.gmtime.strftime("%Y-%m-%d %H:%M:%S Greenwich Mean Time")
#now = Time.new.gmtime.to_s
message_body = <<END_OF_EMAIL
From: Michael Kramer <pianospree@gmail.com>
To: Other kramer <mk@pianospree.com>
Subject: trial text message

This is a test message.
Sent at #{now}
END_OF_EMAIL


server = 'smtp.gmail.com'
#mail_from_domain = 'gmail.com'
port = 587      # or 25 - double check with your provider
username = 'pianospree@gmail.com'
password = 'asdfjkl;5%'

smtp = Net::SMTP.new(server, port)
smtp.enable_starttls_auto
smtp.start(server,username,password, :plain)
smtp.send_message(message_body, fromAddress, toAddress)
puts "Message sent"
exit
