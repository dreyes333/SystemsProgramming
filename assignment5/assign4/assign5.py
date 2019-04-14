#!/usr/bin/env python3

import os
import sys
import glob
import re

if len(sys.argv) != 5:
    print("Error: not enough arguments")
    sys.exit(1)

if not os.path.isdir(sys.argv[1]):
    print("Error: Arg1 - Directory does not exist")
    sys.exit(1)

if not os.path.isfile(sys.argv[2]):
    print("Error: Arg2 - File does not exist")
    sys.exit(1)

if not re.match(r"\d{2}/\d{2}/\d{4}", sys.argv[3]):
    print("Error: Arg3 - Put in MM/DD/YYYY format")
    sys.exit(1)

if not os.path.isdir(sys.argv[4]):
    os.makedirs(sys.argv[4])

aptDir = glob.glob(sys.argv[1] + "/*.apt")

i = 0
j = 0

for file in aptDir:
    
    pathList = aptDir[i].split("/")
    aptNumber = pathList[-1] #-1 gets the last element of the array
    aptNumber = aptNumber.split(".")[0]
    
    with open(file, 'r') as openFile:
        data = openFile.read().split()
        first = data[0]
        last = " ".join(data[1:-3])
        start = data[-3]
        end = data[-2]
        balance = data[-1]
        underscore = "_"
        finalLast = last.replace(" ", "_")
        fileToOpen = ""

    if int(balance) > 0:
        if os.path.isfile(sys.argv[4] + "/" + finalLast + ".mail"):
            j = j + 1
            fileDup = sys.argv[4] + "/" + finalLast + str(j) + ".mail"
            # shutil.copy(sys.argv[2], fileDup)
            fileToOpen = fileDup

        else:
            fileNew = sys.argv[4] + "/" + finalLast + ".mail"
            # shutil.copy(sys.argv[2], fileNew)
            fileToOpen = fileNew
        
        # opens template and copy in the same line
        # fileToOpen is the copy you made of the template
        # sys.argv[2] is the original template
        # you wants to read through the template line by line
        # you modify that line in the template as needed
        # you will then write that modified line to the coyp you made of the template
        # you don't actually make a compy of the template, but by saying that you want to write
        # to a non-existent file, you create it
        with open (fileToOpen, 'w') as letter, open(sys.argv[2], 'r') as sample:
            for text in sample:
                text = text.replace("<<date>>", sys.argv[3])
                text = text.replace("<<first_name>>", first)
                text = text.replace("<<last_name>>", last)
                text = text.replace("<<lease_start>>", start)
                text = text.replace("<<lease_end>>", end)
                text = text.replace("<<apt_number>>", aptNumber)
                text = text.replace("<<balance>>", balance)
                letter.write(text)
                
    i = i+1
