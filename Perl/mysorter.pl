#!/usr/bin/perl

# My Sorter
# Richard Forman
# Sorts arbitrary number of arguments input from the command line
# usage 1 mySorter.pl item1 item2 ... itemN
# usage 2 mySorter.pl -r item1 item2 ... itemN
# usage 3 mySorter.pl --reverse item1 item2 ... itemN

use 5.8.8;
$reverse = 0;				# Initialize reverse flag
@mylist = @ARGV;			# copy Command Line Args

$i=0;
foreach $arg (@mylist){			# Check for reverse flag
#	print $arg . "\n";		# (for debugging)
	if (($arg eq "-r")|($arg eq "--reverse")){
		$reverse = 1;		# Set reverse Flag
		@option = splice @mylist, $i, 1;	#remove option from list
		last;			#exit loop
	} else {
	$i++;
	}
}
#print "post loop args are: "."@mylist"."\n"; # for debugging
if (@mylist < 2) {			# checks for number of arguments
	print "invalid command line arguments to program. ".
	"Please supply two or more strings to sort";
	print "@mylist";
   } else {				# if there are enough arguments..
	@mylist = sort @mylist;		# sort,
	if ($reverse == 1){		# Reverse if flag is set,
		@mylist = reverse @mylist;
	}
	print "@mylist";		# and print
   }
