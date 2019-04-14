#!/bin/bash

read -p "Enter an apartment number: " aptnum
read -p "Enter a payment amount: " pamount

if [[ ! -r "./data/$aptnum.apt" && ! -w "./data/$aptnum.apt" ]];
then
    echo "ERROR: apartment not found."
else
    read_info () {
        read firstname lastname
        read leaseStart leaseEnd
        read accountBalance
    }

    read_info < "./data/$aptnum.apt"

    newbalance=$(($accountBalance-$pamount))

    echo "$firstname $lastname" > "./data/$aptnum.apt"
    echo "$leaseStart $leaseEnd" >> "./data/$aptnum.apt"
    echo "$newbalance" >> "./data/$aptnum.apt"

    echo "[`date`] PAID: $aptnum - AMOUNT: $pamount - NEW BALANCE: $newbalance" >> data/queries.log
fi
