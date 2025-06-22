#!/usr/bin/perl
@lines = `perldoc -u -f GetOpt::Long`;
foreach (@lines){
	s/\w<([^>]+)>/\U$1/g;
	print;
}
