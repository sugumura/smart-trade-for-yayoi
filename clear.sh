#!/bin/sh

user=$1
echo "clear data if press the Enter key."
read Wait

rm -rf data/*.csv
rm -rf out/*.csv

echo "all clear!"

exit 0
