#/usr/bin/ruby

fileHtml = File.new("test.html", "w+")
fileHtml.puts "<HTML><BODY BGCOLOR='green'>"
fileHtml.puts "<CENTER>this is neat</CENTER><br>"
fileHtml.puts "<CENTER><FONT COLOR='yellow'>this is neat</FONT></CENTER>"
fileHtml.puts "</BODY></HTML>"
fileHtml.close()