module Outreach
	require 'mail'
	require 'json'
	require 'encrypted_strings'
	class Secrets
		def Secrets.load(encjsonfile, pw)
			$pw = pw.chomp
			jsonvals = File.read(encjsonfile)
			valhash = JSON.parse(jsonvals)
			$twilioaccountsid = valhash["twilioaccountsid"].decrypt(:symmetric, :algorithm => 'des-ecb', :password => $pw).chomp
			$twilioauthtoken = valhash["twilioauthtoken"].decrypt(:symmetric, :algorithm => 'des-ecb', :password => $pw).chomp
			$twiliophone = valhash["twiliophone"].decrypt(:symmetric, :algorithm => 'des-ecb', :password => $pw).chomp
			$emailaddress = valhash["emailaddress"].decrypt(:symmetric, :algorithm => 'des-ecb', :password => $pw).chomp
			$emailpassword = valhash["emailpassword"].decrypt(:symmetric, :algorithm => 'des-ecb', :password => $pw).chomp
		end
	end

	class Email
		def Email.send(recipient, message)
			@rcpt = recipient
			@msg = message
			now = Time.new.gmtime.strftime("%Y-%m-%d %H:%M:%S Greenwich Mean Time")
			message_body = <<-END_OF_EMAIL
From: Michael Kramer <#{$emailaddress}>
To: #{@rcpt}
Subject: test notification

			#{@msg}
			Sent at #{now}
			END_OF_EMAIL
			server = 'smtp.gmail.com'
			port = 587
			smtp = Net::SMTP.new(server, port)
			smtp.enable_starttls_auto
			smtp.start(server, $emailaddress, $emailpassword, :plain)
			smtp.send_message(message_body, $emailddress, @rcpt)
			puts "Message sent"
		end
	end
	class Sms
		require 'twilio-ruby'
		def Sms.send(to, from, msg) # , passwd)
#			File.open('.twilio') { |f|
#				tmparray  = f.readlines
#				@tw_acct = tmparray.shift.chomp
#				@tw_token = tmparray.shift.chomp
#			}
#			@client = Twilio::REST::Client.new @tw_acct, @tw_token
			@client = Twilio::REST::Client.new $twilioaccountsid, $twilioauthtoken
			@message = @client.messages.create(
			  to: "#{to}",
			  from: "#{from}",
			  body: "#{msg}"
			)
		end
	end
end
