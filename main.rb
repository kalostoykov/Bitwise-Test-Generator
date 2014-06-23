#/usr/bin/ruby
require 'securerandom'
require 'rubygems'
require 'pdfkit'
require 'fileutils'

count = 1
fileNum = ARGV[0].to_i

FileUtils::mkdir_p 'Tests'
location = "Tests/"

while count <= fileNum do
	orig1 = SecureRandom.hex(2)
	orig2 = SecureRandom.hex(2)
	orig3 = SecureRandom.hex(2)
	orig4 = SecureRandom.hex(2)
	orig5 = SecureRandom.hex(2)

	insert1 = SecureRandom.hex(2)
	insert2 = SecureRandom.hex(2)
	insert3 = SecureRandom.hex(2)
	insert4 = SecureRandom.hex(2)
	insert5 = SecureRandom.hex(2)

	i = SecureRandom.hex(2)
	value17 = SecureRandom.hex(2)
	value27 = SecureRandom.hex(2)
	value18 = rand(1024)
	value28 = rand(1024)
	value111 = rand(1024)
	value211 = rand(1024)
	value112 = rand(1024)
	value212 = rand(1024)
	testValue9 = SecureRandom.hex(4)
	testValue10 = SecureRandom.hex(4)
	
	htmltemplate = {
		"1" => "<TD> a = ? .......<br> int orig = 0x#{orig1};<br> int insert = 0x#{insert1};<br> int a = orig | (insert<<8);</TD>",
		"2" => "<TD> b = ? .......<br> int orig = 0x#{orig2};<br> int insert = 0x#{insert2};<br> int a = orig | (insert<<6);</TD>",
		"3" => "<TD>AND = ? .......<br> int orig = 0x#{orig3};<br> int insert = 0x#{insert3};<br> int a = orig | (insert << 8);<br> int b = orig | (insert << 6);<br> int AND = a & b;</TD>",
		"4" => "<TD>OR = ? .......<br> int orig   = 0x#{orig4};<br> int insert = 0x#{insert4};<br> int a = orig | (insert << 7);<br> int b = orig | (insert << 5);<br> int AND = a & b;</TD>",
		"5" => "<TD>OR = ? .......<br> int orig   = 0x#{orig5};<br> int insert = 0x#{insert5};<br> int a = orig | (insert << 7);<br> int b = orig | (insert << 5);<br> int AND = a ^ b;</TD>",
		"6" => "<TD>left = ? .......<br>int i = 0x#{i};<br>int left = 0x#{i} | (1 << 10);<br></TD>",
		"7" => "<TD>result =? .......<br>long value1 = 0x#{value17};<br>long value2 = 0x#{value27};<br>int result = (value1 << 3) ^ (value2 >> 2);</TD>",
		"8" => "<TD>result =? .......<br>int value1 = #{value18};<br>int value2 = #{value28};<br>int result = (value1 << 3) ^ (value2 >> 2);</TD>",
		"9" => "<TD>a = ? .......<br>long testValue = 0x#{testValue9};<br>int a =0;<br>if (testValue & (1 << 4)){<br>a = 1;<br>} else {<br>a = 2;<br>}</TD>",
		"10" => "<TD>a = ?, result = ? .......<br>long testValue = 0x#{testValue10};<br>int a =0;<br>int result = 0;<br>if ( (result = testValue & testValue ^ testValue | (1 << 4)) ) {<br> a = 1;<br>} else {<br> a = 2;<br>}</TD>",
		"11" => "<TD>result =? .......<br>int value1 = #{value111};<br>int value2 = #{value211};<br>int result = (value1 << 3) ^ (value2 >> 2)</TD>",
		"12" => "<TD>result =? .......<br>int value1 = #{value112};<br>int value2 = #{value212};<br>int result = (value1 << 5) ^ (value2 >> 4)</TD>"
	}

	fileName = "test" + "#{count}"
	htmlFileName = fileName + ".html"
	pdfFileName = fileName + ".pdf"
	fileHtml = File.new(location + htmlFileName, "w+")
	fileHtml.puts "<HTML><BODY>"
	fileHtml.puts "<TABLE border = 1"
	fileHtml.puts "<TR>#{htmltemplate["1"]} #{htmltemplate["2"]}</TR>"
	fileHtml.puts "<TR>#{htmltemplate["3"]} #{htmltemplate["4"]}</TR>"
	fileHtml.puts "<TR>#{htmltemplate["5"]} #{htmltemplate["6"]}</TR>"
	fileHtml.puts "<TR>#{htmltemplate["7"]} #{htmltemplate["8"]}</TR>"
	fileHtml.puts "<TR>#{htmltemplate["9"]} #{htmltemplate["10"]}</TR>"
	fileHtml.puts "<TR>#{htmltemplate["11"]} #{htmltemplate["12"]}</TR>"
	fileHtml.puts "</TABLE>"
	fileHtml.puts "</BODY></HTML>"
	fileHtml.close()

	kit = PDFKit.new(File.new(location + htmlFileName))
	kit.to_file(location + pdfFileName)
	
	count += 1
end