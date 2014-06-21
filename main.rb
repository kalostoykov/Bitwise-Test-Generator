#/usr/bin/ruby
require 'securerandom'

orig = SecureRandom.hex(2)
insert = SecureRandom.hex(2)
i = SecureRandom.hex(2)
hvalue1 = SecureRandom.hex(2)
ivalue1 = rand(1024)
hvalue2 = SecureRandom.hex(2)
ivalue2 = rand(1024)

HTMLtemplate = {
"1" => "<TD> a = ? .......<br> int orig = 0x#{orig};<br> int insert = 0x#{insert};<br> int a = orig | (insert<<8);</TD>",
"2" => "<TD> b = ? .......<br> int orig = 0x#{orig};<br> int insert = 0x#{insert};<br> int a = orig | (insert<<6);</TD>",
"3" => "<TD>AND = ? .......<br> int orig = 0x#{orig};<br> int insert = 0x#{insert};<br> int a = orig | (insert << 8);<br> int b = orig | (insert << 6);<br> int AND = a & b;</TD>",
"4" => "<TD>OR = ? .......<br> int orig   = 0x#{orig};<br> int insert = 0x#{insert};<br> int a = orig | (insert << 7);<br> int b = orig | (insert << 5);<br> int AND = a & b;</TD>",
"5" => "<TD>OR = ? .......<br> int orig   = 0x#{orig};<br> int insert = 0x#{insert};<br> int a = orig | (insert << 7);<br> int b = orig | (insert << 5);<br> int AND = a ^ b;</TD>",
"6" => "<TD>left = ? .......<br>int i = 0x#{i};<br>int left = 0x#{i} | (1 << 10);<br></TD>",
"7" => "<TD>result =? .......<br>long value1 = 0x#{hvalue1};<br>long value2 = 0x#{hvalue2};<br>int result = (value1 << 3) ^ (value2 >> 2);</TD>",
"8" => "<TD>result =? .......<br>int value1 = #{ivalue1};<br>int value2 = #{ivalue2};<br>int result = (value1 << 3) ^ (value2 >> 2);</TD>"

}

fileHtml = File.new("test.html", "w+")
fileHtml.puts "<HTML><BODY>"
fileHtml.puts "<TABLE border = 1"
fileHtml.puts "<TR>#{HTMLtemplate["1"]} #{HTMLtemplate["2"]}</TR>"
fileHtml.puts "<TR>#{HTMLtemplate["3"]} #{HTMLtemplate["4"]}</TR>"
fileHtml.puts "<TR>#{HTMLtemplate["5"]} #{HTMLtemplate["6"]}</TR>"
fileHtml.puts "<TR>#{HTMLtemplate["7"]} #{HTMLtemplate["8"]}</TR>"
fileHtml.puts "</TABLE>"
fileHtml.puts "</BODY></HTML>"
fileHtml.close()