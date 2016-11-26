#!/usr/bin/ruby

require 'encrypted_strings'
@file = ARGV[0].dup
if (@file.nil?) then
	printf "Enter json file to encrypt: "
	@file = STDIN.gets
end
@file.chomp!
@encfile = @file + '.enc'
@pw = ARGV[1].dup
if (@pw.nil?) then
	printf "Enter password: "
	@pw = STDIN.gets
end
@pw.chomp!
f = File.open(@file)
g = File.new(@encfile, "w")
lines = f.readlines
lines.each do |line|
	if !line.include?('"') then 
		g.write(line)
		next 
	end
	member = line.split(":")
	member[1] =~ /"([^"]+)"/
	mem1 = $1
	enc1 = mem1.encrypt(:symmetric, :algorithm => 'des-ecb', :password => @pw).chomp
	encline = line.sub(mem1, enc1)
	g.write encline
#	printf "#{member[0]}  =>  #{member[1]}\n"
end

exit
data = "marvelous"
encrypted = data.encrypt(:symmetric, :algorithm => 'des-ecb', :password => pw)
p encrypted
restored = encrypted.decrypt(:symmetric, :algorithm => 'des-ecb', :password => pw)
p restored
