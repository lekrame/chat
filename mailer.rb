#!/usr/bin/ruby -w
require 'net/smtp'

#msgstr = <<END_OF_MESSAGE
msgstr = 'From: Michael Kramer <mk@pianospree.com>
To: Michael Kramer <mk@pianospree.com>
Subject: from Ruby
Date: ' + Time.now.inspect.to_s + '
Message-Id: 001000

This is a test message.
'
#Date: Sat, 23 Jun 2001 16:26:43 +0900
#END_OF_MESSAGE
#msgstr = 'hello
#there
#stranger
#'

#puts msgstr
#Net::SMTP.start('smtpout.secureserver.net', 25, 'localhost', 'mk@pianospree.com', 'sdfjkl', :login)

Net::SMTP.start('smtpout.secureserver.net', 25, 'localhost', 'mk@pianospree.com', 'sdfjkl', :login) do |smtp|
  smtp.send_message msgstr,
                    'mk@pianospree.com',
                    'mk@pianospree.com'
end
