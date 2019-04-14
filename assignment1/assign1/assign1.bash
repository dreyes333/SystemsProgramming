#!/bin/bash

infinite=0
while [ $infinite ]; do
    echo "Enter one of the following actions or press CTRL-D to exit."
    echo "C - create a new apartment record"
    echo "R - read an existing apartment record"
    echo "U - update an existing apartment record"
    echo "D - delete an existing apartment record"
    echo "P - record payment for an existing tenant"
    echo "T - get total apartments"
    if ! read something; then 
        # got EOF
        break
    fi
 case "$something" in
   [Cc]) ./create.bash
   ;;
   [Rr]) ./read.bash
   ;;
   [Uu]) ./update.bash
   ;;
   [Dd]) ./delete.bash
   ;;
   [Pp]) ./payment.bash
   ;;
   [Tt]) ./total.bash
   ;;
   *) ERROR: invalid option
 esac
done



