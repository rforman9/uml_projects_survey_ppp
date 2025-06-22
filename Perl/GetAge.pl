#!/usr/bin/perl

# Hello World
# Richard Forman
# Gets the users age and outputs it
# to the console
# No Arguments

use 5.8.8;


print "Enter Your age:";
$line = <STDIN>;	# read a line from the keyboard
chop $line;		# Remove Carriage return
print "you are ", $line, " years old.\n";
exit;


