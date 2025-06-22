#! /usr/bin/python
# A_ZodiacCalc.py
# Richard Forman
# Script to calculate a Chinese Horoscope sign from
# a Birthday (in digits with no leading zeros) and
# output a text file with the zodiac sign's details.
# Two xml files, AsianZodiac.xml and AnimalSigns.xml,
# are included in the zip and should uncompress
# in the same folder as the script.
# Also this program requires the xml.etree.ElementTree
# module to be installed.

usage = "%prog [options] $BirthMonth $BirthDay $BirthYear"
# i.e. AsianZodiacCalc.py 12 25 1999

import sys, optparse, textwrap, time
import xml.etree.ElementTree as ET
from datetime import date
from xml.etree.ElementTree import tostring, XMLID, dump

Chn_MinYear = 1936
Chn_MaxYear = 2032
in_error = "invalid command line arguments to program.\
 Please supply Date between ", Chn_MinYear," and ", Chn_MaxYear," as m d yyyy "

p = optparse.OptionParser(usage=usage)      # create object for parsing input
opts, args = p.parse_args()

for i in range(len(args)):			# convert args from strings to int
	args[i]=int(args[i])
									# Check the arguments
if ((len(args) < 3) or (args[2] < Chn_MinYear) or (args[2] > Chn_MaxYear)):	
	p.error (in_error)				# exit if not enough arguments or year out of range
	                                # create date object for birth date
b_date = date(args[2], args[0], args[1])

									# read Chinese Calendar years into tree
A_Signs = ET.parse('AnimalSigns_attrib.xml')
years = A_Signs.getroot()

									# read Chinese Zodiac Descriptions into tree
A_Zodiac = ET.parse('AsianZodiac_ID.xml')
animals = A_Zodiac.getroot()
Exported = tostring(animals)		# Convert to string so XMLID can create a ID Map
animals_id, id_map = XMLID(Exported)

									# create date object for Chinese new year for that birth year							
year = years.findall("*[@FromYear='"+str(b_date.year)+"']") 
CNY_date = date(b_date.year,2,int(year[0].get('FromDay')))
								
if (b_date >= CNY_date):			# if birthdate is on or after chinese newyear
	animal = year[0].get('Sign')	# animal = sign for that year	
else:								# else Animal is sign for previous year
	year = years.findall("*[@FromYear='"+str(b_date.year-1)+"']")
	animal = year[0].get('Sign')

traits = id_map.get(animal)			# Lookup Animal Traits in Database

print "\nIf your birth date is", b_date.strftime("%B %d %Y,")\
 ,"your Asian Zodiac sign is", animal
print "The",animal,"sign's main trait is",traits.find('Keyword').text
print "\nSee the file animal.txt for more info.\n\n";

original = sys.stdout				# placeholder for console output
myout = open('animal.txt','w')		
sys.stdout = myout					# redirect output to animal.txt file

print "\n"+textwrap.fill(traits.find('Attributes').text).strip()+"\n"
print "You are most compatible with the signs", traits.find('MostCompatible').text+"\n"
print "You are least compatible with the", traits.find('LeastCompatible').text,"sign."+"\n"

sys.stdout = original				# restore output to console 
myout.close							# close file