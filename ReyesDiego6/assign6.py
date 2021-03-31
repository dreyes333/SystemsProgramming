#!/usr/bin/env python3

import sys
import os
import shutil
import re
import glob

if len(sys.argv) != 2:
    print("Not enough arguments, at least one needed")
    sys.exit(1)

if not os.path.isdir(sys.argv[1]):
    print("Not a directory, try again")
    sys.exit(1)

nameDir = ["assignment"] #list that stores directory names
extractList = list() 

for file in os.listdir(sys.argv[1]): # extracts data between proj and . for all files that contain the word project and stores in list
    if re.search("proj", file):
        extract = re.findall(r"proj([^.]*).\S+", file)
        extractList += extract

for token in set(extractList): # for each extracted element in the list " assignment " is concanated with it to make final directory name 
    nameDir.append("assignment" + token) # Note: set() removes all duplicates from a list

nameDir.append("misc") # appends "misc" to list of directory anmes, now all directory names are there

# goes to the directory that has the files
os.chdir(sys.argv[1])

# creates all of the directories that are in your list
for name in nameDir:
    os.makedirs(name)

for file in os.listdir():
    for name in nameDir:
        extractAgain = re.findall(r"proj([^.]*).\S+", file)
        extractFinal = re.findall(r"assignment([^.]*)", name)
        if file == "proj"  and not os.path.isdir(file):
            try:
                shutil.move(file,"assignment")
            except Exception:
                pass
        elif extractAgain == extractFinal and not os.path.isdir(file):
            shutil.move(file,name) 
