#!/usr/bin/ruby -w

require 'net/smtp'
require "time"
puts "Enter gmail address:"
email = gets.chomp
puts "Enter pw:"
pw = gets.chomp


#msgstr = <<END_OF_MESSAGE
msgstr = 'From: Michael Kramer <#{email}@gmail.com>
To: Michael Kramer <#{email}@gmail.com>
Subject: from Ruby
Date: ' + Time.now.inspect.to_s + '
Message-Id: 001000

This is a test message.
'

STDOUT.puts "email = >>>#{email}<<<<<"

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'localhost', "${email}.gmail.com", "#{pw}", :plain) do |smpt|
#Net::SMTP.start('smtp.gmail.com', 25, 'localhost', email, pw, :plain) do |smpt|
  smtp.send_message (msgstr)
  #smtp.sendmail (msgstr, email, email)
end
#puts msgstr
=begin
=end
