#!/usr/bin/perl

#script to illustrate how to parse a simple xml file
#and pick out a particular element, in this case, the
#title of the book with the ISBN 'Book2ISBN'.

use strict;
use XML::Simple;

# we use KeyAttr +> {book => 'isbn} to tell the parser to create 
# a data structure that uses the isbn element as a lookup key.

my $booklist = XMLin('booklist.xml', KeyAttr => {book => 'isbn'});

print $booklist->{book}->{Book2ISBN}->{title} . "\n";

