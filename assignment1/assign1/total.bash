#!/bin/bash

cd ./data
count=`ls *.apt | wc -l` 

echo "Total apartment records: $count"
