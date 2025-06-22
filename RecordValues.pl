#!/usr/bin/perl

# script to illustrate how to parse a simple xml file
# and pick out all the valuse of a particular element,
# in this case, all the titles.

use strict;
use XML::Simple;

my $booklist = XMLin('booklist.xml');

foreach my $book (@{$booklist->{book}}) {
	print $book->{title} . "\n";
}
