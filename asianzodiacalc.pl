#!/usr/bin/perl

# My Sorter
# Richard Forman

# Script to calculate a Chinese Horoscope sign from
# a Birthday (in digits with no leading zeros) and
# output a text file with the zodiac sign's details.
# Two xml files, AsianZodiac.xml and AnimalSigns.xml,
# are included in the zip and should uncompress
# in the same folder as the script.
# Also this program requires the DateTime, Text::wrap,
# and XML::Simple modules to be installed.

#usage AsianZodiacCalc.pl $BirthMonth $BirthDay $BirthYear
# i.e. AsianZodiacCalc.pl 12 25 1999

use 5.8.8;

# use strict;
use DateTime;
use XML::Simple;
use Text::Wrap qw($columns &wrap);

@mylist = @ARGV;
$birthmonth=@ARGV[0];
$birthday=@ARGV[1];
$birthyear=@ARGV[2];

print "you were born:\n";
print "Month ",$birthmonth,"\n";
print "Day ",$birthday,"\n";
print "of Year ",$birthyear,"\n\n";

print "is this correct? [y/n]:";
chomp(my $response = <stdin>);
if ($response ne "y") {
	print "exiting\n";
	exit 0;
	
} else {
	my $asianzodiac = XMLin('AsianZodiac.xml',KeyAttr => {sign => 'Animal'});
	my $bdt = DateTime->new(
	  year	=> $birthyear,
	  month	=> $birthmonth,
	  day 	=> $birthday,
	);
	my $animalsigns = XMLin('AnimalSigns.xml',KeyAttr => {year => 'FromYear'});
	my $chnewyear = DateTime->new(
	  year 	=> $birthyear,
	  month => 2,
	  day 	=> $animalsigns->{year}->{$birthyear}->{FromDay} 
	);
	if ($bdt >= $chnewyear){
		$animal = $animalsigns->{year}->{$birthyear}->{Sign};
	} else	{
		$animal = $animalsigns->{year}->{($birthyear-1)}->{Sign};
		}
	print "\nYour asian zodiac sign is ",$animal,"!\n\n";
	print "The ",$animal," sign's main trait is ",
		$asianzodiac->{sign}->{$animal}->{Keyword},"\n"
		,"See the file animal.txt for more info.\n\n";
	if (! open MYOUT, '>animal.txt'){
	    die "cannot create animal.txt: $!";
	}
	select MYOUT;
	$columns = 80;
	@input = ("\nIf your Birthday is ",$bdt->mdy,"you're born in a ",$animal,"Year.\n\n",
		$asianzodiac->{sign}->{$animal}->{Attributes},"\n\n",
		"You are most compatible with the signs",
		$asianzodiac->{sign}->{$animal}->{MostCompatible},".\n\n",
		"You are least compatible with the",
		$asianzodiac->{sign}->{$animal}->{LeastCompatible},"sign.\n\n");
	print wrap("    ", "  ", @input), "\n";
	select STDOUT;
	close MYOUT;	
	}

