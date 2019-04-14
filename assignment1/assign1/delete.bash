#!/bin/bash

read -p "Enter an three digit apartment number: " aptnum

if [ -f "./data/$aptnum.apt" ];
then 
    rm "./data/$aptnum.apt"
    echo "[`date`] DELETED: $aptnum" >> ./data/queries.log
    echo "Apartment $aptnum was successfully deleted"
else
    echo "ERROR: apartment not found."
fi
    
