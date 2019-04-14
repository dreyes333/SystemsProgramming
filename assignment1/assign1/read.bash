#!/bin/bash

read -p "Enter an apartment number: " aptnum
echo " "
    if [ ! -r "./data/$aptnum.apt" ];
    then
    echo "Error: apartment not found."
    else
    search_apt () {
        read fname lname
        read leaseS leaseE
        read balance
        echo "Apartment number: $aptnum"
        echo "Tenant Name: $lname, $fname"
        echo "Lease Start: $leaseS"
        echo "Lease End: $leaseE"
        echo "Current Balance: $balance"
    }
    search_apt < "./data/$aptnum.apt"
    fi
                        
