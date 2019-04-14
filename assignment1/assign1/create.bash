#!/bin/bash

read -p "Enter a three digit apartment number: " aptnum
read -p "Enter full name: " first last
read -p "Enter lease start date (mm/dd/yy): " startdate
read -p "Enter lease end date (mm/dd/yy): " enddate

if [ -f "data/$aptnum.apt" ];
then
echo "Error: apartment already exists."
else
echo "$first $last" >> data/"$aptnum.apt"
echo "$startdate $enddate" >> data/"$aptnum.apt"
echo "900" >> data/"$aptnum.apt"

echo "[`date`] CREATED: $aptnum" >> data/queries.log
fi
