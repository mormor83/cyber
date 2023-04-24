#!/bin/bash
#  print the operating system
echo operating system : $(uname -o)

#  print the processor type
echo processor type : $(uname -p)

# Check file zip_job.py exist
FILE=/tmp/zip_job.py
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
fi
