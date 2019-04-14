#!/bin/bash

if [ $# -ne 3 ];
then
    echo " Need at least three arguments, try again. "
    exit 1
fi

if [ ! -d $1 ];
then 
    echo " Directory not found! "
    exit 1
fi

if [[ $3 == "-r" ]]; then
    find  $1 -type f -mtime $2 -exec sed -i -E -f assign2.sed {} \;

else
    find $1 -maxdepth 1 -type f -mtime $2 -exec sed -i -E -f assign2.sed {} \;

fi
