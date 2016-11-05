module Outreach
	class Email
		require 'mail'
		def Email.send(recipient, message, password)
			@pw = password
			@rcpt = recipient
			@msg = message
			fromAddress = 'pianospree@gmail.com'
			toAddress = 'mk@pianospree.com'
			now = Time.new.gmtime.strftime("%Y-%m-%d %H:%M:%S Greenwich Mean Time")

			message_body = <<END_OF_EMAIL
From: Michael Kramer <#{fromAddress}>
To: #{@rcpt}
Subject: test notification

			#{@msg}
			Sent at #{now}
END_OF_EMAIL
			
			server = 'smtp.gmail.com'
			port = 587
			username = fromAddress
			smtp = Net::SMTP.new(server, port)
			smtp.enable_starttls_auto
			smtp.start(server,username,@pw, :plain)
			smtp.send_message(message_body, fromAddress, @rcpt)
			puts "Message sent"
		end
	end
	class Sms
		require 'twilio-ruby'
		def Sms.send(to, from, msg)
			File.open('.twilio') { |f|
				tmparray  = f.readlines
				@tw_acct = tmparray.shift.chomp
				@tw_token = tmparray.shift.chomp
			}
			@client = Twilio::REST::Client.new @tw_acct, @tw_token
			@message = @client.messages.create(
			  to: "#{to}",
			  from: "#{from}",
			  body: "#{msg}"
			)
		end
	end
end