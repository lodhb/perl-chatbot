#!/usr/bin/perl
#Chatbot CGI Script
#BUSI0063 @ Hong Kong University, Assignment 1
#Designed on Google Chrome 12.0.742.112 @ 1600x900
#Tested on Firefox 7.01 and Internet Explorer 9.0.8112.16421
#CSS and Markup validated by w3.org (except autocomplete=off on input field, not W3C valid)
#Laurent OBERHOLZER (loberhol@hku.hk), 02/10/2011

#Import modules needed by the script
	use CGI qw(:standard);
	use Switch;

#Get query from posted form, if a query has indeed been submitted
	$query = new CGI;
	%data = $query->Vars();
	if (defined $data{'userinput'}){
		$userinput = $data{'userinput'};
		}

#Define main subroutine which answers a user's input
	sub answer{
		if($_[0] =~ /how are you/i|| $_[0] =~ /how do you do/i){
		return "Fine, thanks!";
		}
		elsif($_[0] =~ /how old are you/i){
		return "I'm 20 years old.";
		}
		elsif($_[0] =~ /hello/i || $_[0] =~ /hi/i){
		return "Hi!";
		}
		elsif($_[0] =~ /what are you doing/i || $_[0] =~ /what you doing/i || $_[0] =~ /watcha doing/i || $_[0] =~ /what's up/i || $_[0] =~ /waddup/i){
		$random = int(rand(6));
		switch($random){
			case 0 {return "I'm surfin the Internet."}
			case 1 {return "I'm reading Richard Branson's autobiography."}
			case 2 {return "I'm practicing archery."}
			case 3 {return "I was sleeping! :\@"}
			case 4 {return "I'm programming."}
			case 5 {return "I'm eating a snack."}
			}
		}
		elsif($_[0] =~ /good morning/i){
		return "Good morning!";
		}
		elsif($_[0] =~ /good afternoon/i){
		return "Good afternoon!";
		}
		elsif($_[0] =~ /good evening/i){
		return "Good evening!";
		}
		elsif($_[0] =~ /good night/i){
		return "Good night! Sleep well!";
		}
		elsif($_[0] =~ /who are you/i){
		return "I am Laurent, and I study at HKU. Contact me at: <a href=\"mailto:loberhol\@hku.hk\">loberhol\@hku.hk</a>";
		}
		elsif($_[0] eq ""){
		return "Say something!";
		}
		elsif($_[0] =~ /^what is (.*)/i){
		@words = split(' ',$_[0]);
		@unknownarr = splice(@words, 2, @words-1);
		$unknown = join(' ', @unknownarr);
		$definition = &define($unknown);
		return $definition;
		}
		elsif($_[0] =~ /^do you know what is (.*)?/i){
		@words = split(' ',$_[0]);
		@unknownarr = splice(@words, 5, @words-1);
		$unknown = join(' ', @unknownarr);
		$definition = &define($unknown);
		return $definition;
		}
		elsif($_[0] =~ /do you know what (.*)? is/i){
		@words = split(' ',$_[0]);
		@unknownarr = splice(@words, 4, @words-2);
		pop(@unknownarr);
		$unknown = join(' ', @unknownarr);
		$definition = &define($unknown);
		return $definition;
		}
		elsif($_[0] =~ /i am/i){
		$clean = $_[0];
		$clean =~ s/[^\w]/ /g;
		@words = split(' ',$clean);
		shift(@words);
		shift(@words);
		$state = join(' ', @words);
		return "Why are you $state?";
		}
		elsif($_[0] =~ /^who is (.*)/i){
		@words = split(' ',$_[0]);
		@unknownarr = splice(@words, 2, @words-1);
		$unknown = join(' ', @unknownarr);
		$definition = &definewho($unknown);
		return $definition;
		}
		elsif($_[0] =~ /^do you know who is (.*)/i){
		@words = split(' ',$_[0]);
		@unknownarr = splice(@words, 5, @words-1);
		$unknown = join(' ', @unknownarr);
		$definition = &definewho($unknown);
		return $definition;
		}
		elsif($_[0] =~ /^do you know who (.*) is/i){
		@words = split(' ',$_[0]);
		@unknownarr = splice(@words, 4, @words-2);
		pop(@unknownarr);
		$unknown = join(' ', @unknownarr);
		$definition = &definewho($unknown);
		return $definition;
		}
		else{
		return "I'm not quite sure what you mean.";
		}
	}

#Define secondary subroutine which gives definitions for WHAT IS XXX type questions
	sub define{
		#Clean the input (e.g. to get rid of question marks)
		$_[0] =~ s/[^\w]/ /g;
		
		if($_[0] =~ /perl/){
		return "A high-level programming language used esp. for applications running on the World Wide Web.";
		}
		elsif($_[0] =~ /php/i){
		return "PHP is a general-purpose server-side scripting language originally designed for web development to produce dynamic web pages.";
		}
		elsif($_[0] =~ /jsp/i){
		return "JavaServer Pages (JSP) is a Java technology that helps software developers serve dynamically generated web pages based on HTML, XML, or other document types.";
		}
		elsif($_[0] =~ /python/i){
		return "Python is a general-purpose, high-level programming language whose design philosophy emphasizes code readability.";
		}
		elsif($_[0] =~ /ruby/i){
		return "Ruby is a dynamic, reflective, general-purpose object-oriented programming language that combines syntax inspired by Perl with Smalltalk-like features.";
		}
		elsif($_[0] =~ /internet/i){
		return "The Internet is a global system of interconnected computer networks that use the standard Internet Protocol Suite (TCP/IP) to serve billions of users worldwide.";
		}
		elsif($_[0] =~ /web server/i){
		return "Web server can refer to either the hardware (the computer) or the software (the computer application) that helps to deliver content that can be accessed through the Internet.\
		The most common use of web servers is to host web sites but there are other uses like data storage or for running enterprise applications.";
		}
		elsif($_[0] =~ /http/i){
		return "The Hypertext Transfer Protocol (HTTP) is a networking protocol for distributed, collaborative, hypermedia information systems.";
		}
		elsif($_[0] =~ /web browser/i){
		return "A web browser is a software application for retrieving, presenting, and traversing information resources on the World Wide Web.";
		}
		elsif($_[0] =~ /archery/i){
		return "Archery is the art, practice, or skill of propelling arrows with the use of a bow, from \"arcus\".";
		}
		else{
		@words = split(' ',$_[0]);
		$googlequery = join('+', @words);
		return "I don't know what $_[0] is. Check out  <a href=\"http://www.google.com/search\?q=$googlequery\" target=\"_blank\">Google</a>."; 
		}
	}

#Define alternative secondary subroutine which gives definitions for WHO IS XXX type questions
	sub definewho{
		#Clean the input (e.g. to get rid of question marks)
		$_[0] =~ s/[^\w]/ /g;
		
		if($_[0] =~ /richard branson/i){
		return "Sir Richard Charles Nicholas Branson (born 18 July 1950) is an English business magnate, best known for his Virgin Group of over 400 companies. Read more about him <a href=\"http://en.wikipedia.org/wiki/Richard_branson\">on Wikipedia</a>";
		}
		else{
		@words = split(' ',$_[0]);
		$googlequery = join('+', @words);
		return "I don't know who $_[0] is. Check out  <a href=\"http://www.google.com/search\?q=$googlequery\" target=\"_blank\">Google</a>."; 
		}
	}
	
#HTML START
	print header();
	print "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n";
	print "<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\" xml:lang=\"en\">\n";
	print "<head><title>Smartbot</title>\n";
#CSS START (to make things look nice!)
	print "<style type=\"text/css\">\n";
	print "<!--\n";
	print "#chatdiv {clear:both;margin:0;margin-top:50px;background-color:#1C6DAC;width:100%;height:18px;}\n";
	print "#chatdiv #form {text-align:center;height:18px}\n";
	print "#chatdiv #form #text{padding:0px;border:0px;margin:0px;vertical-align:text-top;background-color:#DCDCDC;height:18px;width:331px;}\n";
	print "#chatdiv #form #submit, #chatdiv #form #reset {width: 61px;}\n";
	print "#chatdiv #form input {padding:0px;padding-left:10px;padding-right:10px;border:0px;margin:0px;vertical-align:text-top;height:18px;}\n";
	print "form {height:18px;margin:0px;padding:0px;vertical-align:text-top;}\n";
	print "#user {width:453px;}\n";
	print "#script {color: blue; font-weight: bold;width:453px;}\n";
	print "a, a:visited {text-decoration: none; color: red;}\n";
	print "a:active, a:hover {text-decoration: none; color: blue;}\n";
	print "#chattext {position: relative;width:453px;margin:0px auto;text-align:center;margin-top:330px;height:100px;}\n";
	print "-->\n";
	print "</style>\n";
#CSS END
	print "</head>\n";
	print "<body>\n";
	print "<div id=\"chattext\">\n";
#If the user hasn't entered a query (e.g. upon arrival on page), blank display. Otherwise, display QUERY-ANSWER pair.
	if(defined $userinput){
		$answer = &answer($userinput);
		print "<p><span id=\"user\">$userinput<\span></p>\n";
		print "<p><span id=\"script\">$answer<\span></p>\n";
	}
	else{
		print "<p>&nbsp;</p>\n";
		print "<p>&nbsp;</p>\n";
		}
	print "</div>\n";
	print "<div id=\"chatdiv\">\n";
	print "<div id=\"form\">\n";
	print "<form action=\"chat.pl\" method=\"get\" autocomplete=\"off\">\n";
	print "<input type=\"reset\" value=\"Reset\" id=\"reset\"/><input type=\"text\" name=\"userinput\" size=\"50\" id=\"text\" maxlength=\"160\" /><input type=\"submit\" value=\"Submit\" id=\"submit\"/>\n";
	print "</form>\n";
	print "</div>\n";
	print "</div>\n";
	print "</body>\n";
	print "</html>\n";
#HTML END
