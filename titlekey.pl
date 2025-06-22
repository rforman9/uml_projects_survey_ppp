#!/usr/bin/perl

#script to illustrate how to parse a simple xml file
#and pick out a particular element, in this case, the
#title of the book with the ISBN 'Book2ISBN'.

use strict;
use XML::Simple;

# we use KeyAttr +> {book => 'title'} to tell the parser to create 
# a data structure that uses the title element as a lookup key.

my $booklist = XMLin('booklist.xml', KeyAttr => {book => 'title'});

print $booklist->{book}->{'Book 3 title'}->{isbn} . "\n";

