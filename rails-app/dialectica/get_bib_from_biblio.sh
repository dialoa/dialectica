#!/bin/bash

#creates a new bib file
touch fresh_biblio.bib

#iterates over the keys in keys.txt
while read k; do

  #searches and iterates over the search results
  grep $k biblio.bib | while read -r line; do
    echo "Found $line";
    #adds found line to the bib file
    echo $line >> fresh_biblio.bib
  done

done <keys.txt
