#!/bin/bash

############################################################################
# TODO:
# * We're not validating input
############################################################################

# o stands for origin
# d stands for destiny

or=$1 
og=$2 
ob=$3 
dr=$4 
dg=$5 
db=$6
read string

echo "or: $or";
echo "og: $og";
echo "ob: $ob";
echo "dr: $dr";
echo "dg: $dg";
echo "db: $db";
echo "st: $string";

slength=`echo -n $string|wc -c`;
echo "string size: $slength";

# distance = last - first
# increment = distance / slength

distr=`expr $dr - $or`
distg=`expr $dg - $og`
distb=`expr $db - $ob`

echo "distances: $distr $distg $distb";

ir=$(awk -v d=$distr -v s=$slength 'BEGIN { print (d /s) }')
ig=$(awk -v d=$distg -v s=$slength 'BEGIN { print (d /s) }')
ib=$(awk -v d=$distb -v s=$slength 'BEGIN { print (d /s) }')

echo "increments: $ir $ig $ib";

echo "Result:";

# for each character of the string...
for i in `seq 1 $slength`; do
	printr=`seq $or $ir $dr|head -n$i|tail -n1`;
	printg=`seq $og $ig $dg|head -n$i|tail -n1`;
	printb=`seq $ob $ib $db|head -n$i|tail -n1`;
	# print the color code
	echo -n "%x<"; 
	echo -n $printr|awk '{print int($1+0.5)}'|tr '\n' ' ';
	echo -n $printg|awk '{print int($1+0.5)}'|tr '\n' ' ';
	echo -n $printb|awk '{print int($1+0.5)}'|tr '\n' '>'; 
	# print the character
	echo -n "${string:$i-1:1}"; 
done

echo "";
