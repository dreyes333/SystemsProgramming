#!/bin/bash

read -p "Enter a three digit apartment number: " aptnum
read -p "Enter your full name: " fname lname
read -p "Enter the lease start date(dd/mm/yy): " leaseS
read -p "Enter the lease end date(dd/mm/yy): " leaseE
read -p "Enter the account balance: " balance

if [[ ! -r "./data/$aptnum.apt" && ! -w "./data/$aptnum.apt" ]];
then
echo "Error: apartment not found."
else
    read_info () {
        read firstname lastname
        read leaseStart leaseEnd
        read accountbalance
        }

    read_info < "./data/$aptnum.apt"

    update_info () {
        if [ -z "$fname" ];
        then
        fname="$firstname"        
        fi

        if [ -z "$lname" ];
        then
        lname="$lastname"
        fi

        if [ -z "$leaseS" ];
        then
        leaseS="$leaseStart"
        fi

        if [ -z "$leaseE" ];
        then
        leaseE="$leaseEnd"
        fi

        if [ -z "$balance" ];
        then
        balance="$accountbalance"
        fi

        echo "$fname $lname" >> "./data/$aptnum.apt"
        echo "$leaseS $leaseE" >> "./data/$aptnum.apt"
        echo "$balance" >> "./data/$aptnum.apt"
    }

    update_info > "./data/$aptnum.apt"
    
    echo "[`date`] UPDATED: $aptnum" >> data/queries.log

    fi
