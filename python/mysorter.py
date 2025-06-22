# My Sorter
# Richard Forman
# Sorts arbitrary number of arguments input from the command line
usage = "%prog [options] arg1 arg2 ... argN"
# usage 2 mySorter.py -r item1 item2 ... itemN
# usage 3 mySorter.py --reverse item1 item2 ... itemN

import sys, optparse

p = optparse.OptionParser(usage=usage)      # create object for parsing options
                                    # add reverse option to optionparser object
p.add_option("-r", "--reverse", action="store_true", dest="reverse",\
 help = 'sort arguments in descending order')

p.set_defaults(reverse=False)       # set the default sorting mode

opts, args = p.parse_args()         # get args and options from command line

if len(args) < 2:	                # Check the number of arguments
	p.error ("\ninvalid command line arguments to program.\
 Please supply two or more strings to sort ")
	                                # exit if not enough arguments
                                    # sort args in forward or reverse
                                    # depending on reverse option
args.sort(key=str,reverse=opts.reverse)
print args                          # print sorted args