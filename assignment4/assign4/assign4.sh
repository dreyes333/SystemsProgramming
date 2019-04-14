#!/bin/bash

search_apt () {
    read fname lname
    read leaseS leaseE
    read balance
}

if [ $# -lt 4 ]; then
    echo "Error: Not enough arguments"
fi

if [ ! -d $1 ]; then 
    echo "Error: Arg1 -  Directory does not exist"
fi

if [ ! -f $2 ]; then
    echo "Error: Arg2 - File does not exist"
fi

if [ ! -d $4 ]; then
    mkdir $4
fi

i=0 #counter which may be used later if file name is same 

for file in $1/*.apt; do
     search_apt < "$file" #reads data for each file in the directory
    

        if [[ $balance -gt 0 ]]; then

            aptnum=$(echo "$file" | awk -F. 'BEGIN{FS="."}{ print $1 }' - | awk -F/ 'BEGIN{FS="/"}{ print $2}' - ) #variable that holds command that extracts aptnumber from file name
            underscore=$(echo "$lname" | sed 's/[ ]/_/') #variable that holds command to put an underscore for long last names 
        
            if [ -f $4/"$underscore".mail ]; then

                if [[ $3 != [0-1][0-9]/[0-3][0-9]/[0-9][0-9][0-9][0-9] ]]; then
                    echo "Incorrect Format, try this one : MM/DD/YYYY"
                else
                    i=$(($i+1)) 
                    if [[ $5 == "{" ]] || [[ $5 == "}" ]] || [[ $5 == "|" ]] || [[ $5 == "/" ]]; then
                        if [[ $6 == "{" ]] || [[ $6 == "}" ]] || [[ $6 == "|" ]] || [[ $6 == "/" ]] ; then
                            #i=$(($i+1)) original
                            sed "-e s!$5first_name$6!$fname!g" "-e s!$5last_name$6!$lname!g" "-e s!$5lease_start$6!$leaseS!g" "-e s!$5lease_end$6!$leaseE!g" "-e s!$5balance$6!$balance!g" "-e s!$5apt_number$6!"$aptnum"!g" "-e s!$5date$6!$3!g" $2 > $4/"$underscore$i".mail
                        continue
                        fi
                    fi
                    #i=$(($i+1))
                    sed "-e s/<<first_name>>/$fname/g" "-e s/<<last_name>>/$lname/g" "-e s|<<lease_start>>|$leaseS|g" "-e s|<<lease_end>>|$leaseE|g" "-e s/<<balance>>/$balance/g" "-e s|<<apt_number>>|"$aptnum"|g" "-e s|<<date>>|$3|g" $2 > $4/"$underscore$i".mail
                fi

            else

                if [[ $3 != [0-1][0-9]/[0-3][0-9]/[0-9][0-9][0-9][0-9] ]]; then
                     echo "Incorrect Format, try this one : MM/DD/YYYY"
                else

                    if [[ $5 == "{" ]] || [[ $5 == "}" ]] || [[ $5 == "|" ]] || [[ $5 == "/" ]]; then
                        if [[ $6 == "{" ]] || [[ $6 == "}" ]] || [[ $6 == "|" ]] || [[ $6 == "/" ]] ; then
                            sed "-e s!$5first_name$6!$fname!g" "-e s!$5last_name$6!$lname!g" "-e s!$5lease_start$6!$leaseS!g" "-e s!$5lease_end$6!$leaseE!g" "-e s!$5balance$6!$balance!g" "-e s!$5apt_number$6!"$aptnum"!g" "-e s!$5date$6!$3!g" $2 > $4/"$underscore".mail
                        continue
                        fi
                    fi
                     sed "-e s/<<first_name>>/$fname/g" "-e s/<<last_name>>/$lname/g" "-e s|<<lease_start>>|$leaseS|g" "-e s|<<lease_end>>|$leaseE|g" "-e s/<<balance>>/$balance/g" "-e s|<<apt_number>>|"$aptnum"|g" "-e s|<<date>>|$3|g" $2 > $4/"$underscore".mail
                fi
            fi
        fi
done
