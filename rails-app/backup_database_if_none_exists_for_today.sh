FILE=~/backups/dialectica/"$(date +"%y-%m-%d")".dump
if test -f "$FILE"
then
  echo "$FILE exists."
else
  ./get_database_from_digital_ocean.sh
fi
