# My Sorter
# Richard Forman
# Sorts arbitrary number of arguments input from the command line
# usage 1 mySorter.py item1 item2 ... itemN
# usage 2 mySorter.py -r item1 item2 ... itemN
# usage 3 mySorter.py --reverse item1 item2 ... itemN

import sys

reverse = False			# set default sort mode
 
if len(sys.argv) < 3:	# Check the number of arguments
	print "invalid command line arguments to program.\
	\nPlease supply two or more strings to sort "
	raise SystemExit(1)

for item in sys.argv: 	# sort tha list and print it
	print item,

