#!/usr/bin/perl

# Script to illustrate how to parse a simple xml file
# and dump it's contents into a perl hash record.

use strict;
use XML::Simple;
use Data::Dumper;

my $animalsigns = XMLin('AnimalSigns.xml',KeyAttr => {fromyear => 'FromYear'});

print Dumper($animalsigns);

