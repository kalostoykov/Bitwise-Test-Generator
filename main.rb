#/usr/bin/ruby
require 'securerandom'
require 'rubygems'
require 'pdfkit'
require 'fileutils'

count = 1
fileNum = ARGV[0].to_i

FileUtils::mkdir_p 'Tests'
FileUtils::mkdir_p 'Answers'
testLocation = "Tests/"
answerLocation = "Answers/"

def compile (htmltemplate, ctemplate, id)
	b = htmltemplate[id].split(" ")[1]
	code = "#include <stdio.h>\n int main(){" + ctemplate[id] + "printf(\"%x\", #{b});return 0;}"
	File.write('code.c', code)
	`gcc code.c`
	a = `./a.out`
	puts a
end

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
		"3" => "<TD> AND = ? .......<br> int orig = 0x#{orig3};<br> int insert = 0x#{insert3};<br> int a = orig | (insert << 8);<br> int b = orig | (insert << 6);<br> int AND = a & b;</TD>",
		"4" => "<TD> OR = ? .......<br> int orig = 0x#{orig4};<br> int insert = 0x#{insert4};<br> int a = orig | (insert << 7);<br> int b = orig | (insert << 5);<br> int AND = a & b;</TD>",
		"5" => "<TD> OR = ? .......<br> int orig = 0x#{orig5};<br> int insert = 0x#{insert5};<br> int a = orig | (insert << 7);<br> int b = orig | (insert << 5);<br> int AND = a ^ b;</TD>",
		"6" => "<TD> left = ? .......<br>int i = 0x#{i};<br>int left = 0x#{i} | (1 << 10);<br></TD>",
		"7" => "<TD> result =? .......<br>long value1 = 0x#{value17};<br>long value2 = 0x#{value27};<br>int result = (value1 << 3) ^ (value2 >> 2);</TD>",
		"8" => "<TD> result =? .......<br>int value1 = #{value18};<br>int value2 = #{value28};<br>int result = (value1 << 3) ^ (value2 >> 2);</TD>",
		"9" => "<TD> a = ? .......<br>long testValue = 0x#{testValue9};<br>int a =0;<br>if (testValue & (1 << 4)){<br>a = 1;<br>} else {<br>a = 2;<br>}</TD>",
		"10" => "<TD> a = ?, result = ? .......<br>long testValue = 0x#{testValue10};<br>int a =0;<br>int result = 0;<br>if ( (result = testValue & testValue ^ testValue | (1 << 4)) ) {<br> a = 1;<br>} else {<br> a = 2;<br>}</TD>",
		"11" => "<TD> result =? .......<br>int value1 = #{value111};<br>int value2 = #{value211};<br>int result = (value1 << 3) ^ (value2 >> 2)</TD>",
		"12" => "<TD> result =? .......<br>int value1 = #{value112};<br>int value2 = #{value212};<br>int result = (value1 << 5) ^ (value2 >> 4)</TD>"
	}

	ctemplate = {
		"1" => "int orig = 0x#{orig1};int insert = 0x#{insert1};int a = orig | (insert<<8);",
		"2" => "int orig = 0x#{orig2};int insert = 0x#{insert2};int a = orig | (insert<<6);",
		"3" => "int orig = 0x#{orig3};int insert = 0x#{insert3};int a = orig | (insert << 8); int b = orig | (insert << 6);int AND = a & b;",
		"4" => "int orig = 0x#{orig4};int insert = 0x#{insert4};int a = orig | (insert << 7); int b = orig | (insert << 5);int AND = a & b;",
		"5" => "int orig = 0x#{orig5};int insert = 0x#{insert5};int a = orig | (insert << 7); int b = orig | (insert << 5);int AND = a ^ b;",
		"6" => "int i = 0x#{i};int left = 0x#{i} | (1 << 10);",
		"7" => "long value1 = 0x#{value17};long value2 = 0x#{value27};int result = (value1 << 3) ^ (value2 >> 2);",
		"8" => "int value1 = #{value18};int value2 = #{value28};int result = (value1 << 3) ^ (value2 >> 2);",
		"9" => "long testValue = 0x#{testValue9};int a =0;if (testValue & (1 << 4)){a = 1;} else {a = 2;}",
		"10" => "long testValue = 0x#{testValue10};int a =0;int result = 0;if ( (result = testValue & testValue ^ testValue | (1 << 4)) ) { a = 1;} else { a = 2;",
		"11" => "int value1 = #{value111};int value2 = #{value211};int result = (value1 << 3) ^ (value2 >> 2);",
		"12" => "int value1 = #{value112};int value2 = #{value212};int result = (value1 << 5) ^ (value2 >> 4);"
	}

	fileName = "test" + "#{count}"
	htmlFileName = fileName + ".html"
	pdfFileName = fileName + ".pdf"
	
	fileHtml = File.new(testLocation + htmlFileName, "w+")
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

	kit = PDFKit.new(File.new(testLocation + htmlFileName))
	kit.to_file(testLocation + pdfFileName)
	
	compile(htmltemplate, ctemplate,"1")
	index = 1
	while index <= 12
		compile(htmltemplate, ctemplate, "#{index}")
		index += 1
	end
	fileHtml = File.new(answerLocation + htmlFileName, "w+")
	fileHtml.puts "<HTML><BODY>"
	fileHtml.puts "answer"
	fileHtml.puts "</BODY></HTML>"

	count += 1
end
