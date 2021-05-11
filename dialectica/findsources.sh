#!/bin/bash

f2=$(echo "$1"|sed "s/\.bbl//g")
echo "KEY,PDF">"$f2"_found.csv
echo "KEY,STATUS">"$f2"_not_found.csv
mkdir "$f2""_PDF_Files"

#extract keys
cat $1|grep "\\\bibitem"|grep -o "{[^}]*:[0-9][^}]*"|sed "s/{//g">keys.txt

# create text file with all pdf filenames
ls|grep "\.pdf">a-filenames.txt

# loop through keys.txt
while read k; do
# see if the key is in a-filenames.txt
# k2 is the key but with ":" replaced with "-"

k2=$(echo $k|sed "s/:/-/g")
have_file=$(cat a-filenames.txt|grep -c "$k2"".pdf")

echo ""
if [[ $have_file == 1 ]]
	then
	echo "$k"
	filename="$k2"".pdf"
fi

if [[ $have_file == 0 ]]
	then
	echo "$k"
	echo "	- file not found in a-filenames.txt - checking biblio.bib"
	#check for other cross citations or citation in notes
	cross_ref=$(cat biblio.bib|grep "@[^}]*$k[^a-z]*,"|grep -o "crossref = [^}]*"|grep -o "[a-z][^{]*:[0-9][0-9][0-9][0-9]")
	cross_ref_len=$(echo "$cross_ref"|wc -c)

	if [[ $cross_ref_len -gt 5 ]]
		then
		cross_ref2=$(echo $cross_ref|sed "s/:/-/g")
		echo "	- looking for file listed in crossref: ""$cross_ref2"".pdf"
		have_file=$(cat a-filenames.txt|grep -c "$cross_ref2"".pdf")


	if [[ $have_file == 1 ]]
		then
		filename="$cross_ref2"".pdf"
		else
		note=$(cat biblio.bib|grep "@[^}]*$k[^a-z]*,"|grep -o "note = [^}]*"|grep -vi "review of \\\cite"|grep -o "[a-z][^{]*:[0-9][0-9][0-9][0-9]")
		note_len=$(echo "$note"|wc -c)
	fi
	fi

	if [ $note_len -gt 5 ] && [ $have_file == 0 ]
		then
		note2=$(echo $note|sed "s/:/-/g")
		echo "	- looking for file listed in note: ""$note2"".pdf"
		have_file=$(cat a-filenames.txt|grep -c "$note2"".pdf")
		filename="$note2"".pdf"
	fi



fi

if [[ $have_file == 0 ]]
then
#if found nowhere add to log.txt
echo "*	$k"": file not found anywhere - adding entry to log"
echo "$k"", file not found!">>"$f2"_not_found.csv
echo ""
fi

if [[ $have_file -ge 1 ]]
then
echo "	File found:" "$filename"
echo "$k","$filename">>"$f2"_found.csv
#transfer file to new folder
cp "$filename" $f2"_PDF_Files"
#
fi

have_file=0
note=""
note_len=0
cross_ref=""
cross_ref_len=0

done <keys.txt
